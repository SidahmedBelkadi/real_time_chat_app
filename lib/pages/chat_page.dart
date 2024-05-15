import 'dart:io';

import 'package:chat/models/chat.dart';
import 'package:chat/models/message.dart';
import 'package:chat/models/user_profile.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/db_service.dart';
import 'package:chat/services/media_service.dart';
import 'package:chat/services/storage_service.dart';
import 'package:chat/utils/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChatPage extends StatefulWidget {
  final UserProfile chatUser;
  const ChatPage({super.key, required this.chatUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GetIt getIt = GetIt.instance;
  late AuthService _authService;
  late DatabaseService _databaseService;
  late MediaService _mediaService;
  late StorageService _storageService;
  ChatUser? currentUser, otheruser;

  @override
  void initState() {
    super.initState();
    _authService = getIt.get<AuthService>();
    _databaseService = getIt.get<DatabaseService>();
    _mediaService = getIt.get<MediaService>();
    _storageService = getIt.get<StorageService>();
    currentUser = ChatUser(id: _authService.user!.uid, firstName: _authService.user!.displayName);
    otheruser = ChatUser(
      id: widget.chatUser.uid!,
      firstName: widget.chatUser.name!,
      profileImage: widget.chatUser.pfpURL,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatUser.name!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: _databaseService.getChatData(uid1: currentUser!.id, uid2: otheruser!.id),
          builder: (context, snapshot) {
            Chat? chat = snapshot.data?.data();
            List<ChatMessage> messages = [];
            if (chat != null && chat.messages != null) {
              messages = _generateChatMessagesList(messages: chat.messages!);
            }
            return DashChat(
              messageOptions: const MessageOptions(
                showOtherUsersAvatar: true,
                showTime: true,
              ),
              inputOptions: InputOptions(alwaysShowSend: true, trailing: [_mediaMessageButton()]),
              currentUser: currentUser!,
              onSend: _sendMessage,
              messages: messages,
            );
          },
        ),
      ),
    );
  }

  Future<void> _sendMessage(ChatMessage chatMessage) async {
    if (chatMessage.medias?.isNotEmpty ?? false) {
      Message message = Message(
        senderID: chatMessage.user.id,
        content: chatMessage.medias!.first.url,
        messageType: MessageType.Image,
        sentAt: Timestamp.fromDate(chatMessage.createdAt),
      );

      await _databaseService.sendChatMessage(
          uid1: currentUser!.id, uid2: otheruser!.id, message: message);
    } else {
      Message message = Message(
        senderID: currentUser!.id,
        content: chatMessage.text,
        messageType: MessageType.Text,
        sentAt: Timestamp.fromDate(chatMessage.createdAt),
      );

      await _databaseService.sendChatMessage(
          uid1: currentUser!.id, uid2: otheruser!.id, message: message);
    }
  }

  List<ChatMessage> _generateChatMessagesList({required List<Message> messages}) {
    List<ChatMessage> chatMessages = messages.map((Message m) {
      if (m.messageType == MessageType.Image) {
        return ChatMessage(
            user: m.senderID == currentUser!.id ? currentUser! : otheruser!,
            medias: [
              ChatMedia(url: m.content!, fileName: '', type: MediaType.image),
            ],
            createdAt: m.sentAt!.toDate());
      } else {
        return ChatMessage(
            user: m.senderID == currentUser!.id ? currentUser! : otheruser!,
            text: m.content!,
            createdAt: m.sentAt!.toDate());
      }
    }).toList();
    chatMessages.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );
    return chatMessages;
  }

  Widget _mediaMessageButton() {
    return IconButton(
      onPressed: () async {
        File? file = await _mediaService.getImageFromGallery();
        if (file != null) {
          String chatID = generateChatID(uid1: currentUser!.id, uid2: otheruser!.id);
          String? downloadURL = await _storageService.uploadImageToChat(file: file, chatId: chatID);
          if (downloadURL != null) {
            ChatMessage chatMessage =
                ChatMessage(user: currentUser!, createdAt: DateTime.now(), medias: [
              ChatMedia(url: downloadURL, fileName: '', type: MediaType.image),
            ]);
            _sendMessage(chatMessage);
          }
        }
      },
      icon: Icon(
        Icons.image,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}