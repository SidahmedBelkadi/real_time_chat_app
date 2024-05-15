import 'package:chat/models/chat.dart';
import 'package:chat/models/message.dart';
import 'package:chat/models/user_profile.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/utils/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class DatabaseService {
  final GetIt getIt = GetIt.instance;
  late AuthService _authService;

  DatabaseService() {
    _setupCollectionReferences();
    _authService = getIt.get<AuthService>();
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? _userCollection;
  CollectionReference? _chatCollection;

  void _setupCollectionReferences() {
    _userCollection = _firebaseFirestore.collection("users").withConverter<UserProfile>(
          fromFirestore: (snapshot, _) => UserProfile.fromJson(snapshot.data()!),
          toFirestore: (userProfile, _) => userProfile.toJson(),
        );

    _chatCollection = _firebaseFirestore.collection("chats").withConverter<Chat>(
          fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
          toFirestore: (chat, _) => chat.toJson(),
        );
  }

  Future<void> creteUserProfile({required UserProfile userProfile}) async {
    await _userCollection?.doc(userProfile.uid).set(userProfile);
  }

  Stream<QuerySnapshot<UserProfile>> getUserProfiles() {
    return _userCollection?.where('uid', isNotEqualTo: _authService.user!.uid).snapshots()
        as Stream<QuerySnapshot<UserProfile>>;
  }

  Future<bool> checkChatExists({required String uid1, required String uid2}) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final result = await _chatCollection?.doc(chatID).get();
    if (result != null) {
      return result.exists;
    }
    return false;
  }

  Future<void> createNewChat({required String uid1, required String uid2}) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final docRef = _chatCollection!.doc(chatID);
    final chat = Chat(id: chatID, participants: [uid1, uid2], messages: []);

    await docRef.set(chat);
  }

  Future<void> sendChatMessage({
    required String uid1,
    required String uid2,
    required Message message,
  }) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final docRef = _chatCollection!.doc(chatID);
    await docRef.update({
      "messages": FieldValue.arrayUnion([message.toJson()]),
    });
  }

  Stream<DocumentSnapshot<Chat>> getChatData({required String uid1, required String uid2}) {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    return _chatCollection?.doc(chatID).snapshots() as Stream<DocumentSnapshot<Chat>>;
  }
}
