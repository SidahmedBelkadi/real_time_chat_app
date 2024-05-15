import 'package:chat/core/constants/strings.dart';
import 'package:chat/models/user_profile.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/db_service.dart';
import 'package:chat/utils/routing/app_router.dart';
import 'package:chat/utils/toast.dart';
import 'package:chat/widgets/chat_tile.dart';
import 'package:chat/widgets/home/drawer.dart';
import 'package:chat/widgets/loading_widget.dart';
import 'package:chat/widgets/simple_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetIt get = GetIt.instance;

  late AuthService _authService;
  late DatabaseService _databaseService;

  @override
  void initState() {
    _authService = get.get<AuthService>();
    _databaseService = get.get<DatabaseService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kMessages),
      ),
      drawer: HomeDrawer(onLogoutTap: () async {
        bool result = await _authService.logout();
        if (result) {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            AppToasts.showSuccessToast(message: kDisconnected, context: context);
          }
        }
      }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: _databaseService.getUserProfiles(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const SimpleErrorWidget();
              }
              if (snapshot.hasData && snapshot.data != null) {
                final users = snapshot.data!.docs;
                return ListView.separated(
                  itemCount: users.length,
                  itemBuilder: (_, int index) {
                    UserProfile user = users[index].data();
                    return ChatTile(
                      userProfile: user,
                      onTap: () async {
                        final chatExists = await _databaseService.checkChatExists(
                          uid1: _authService.user!.uid,
                          uid2: user.uid!,
                        );
                        debugPrint("$chatExists");
                        if (!chatExists) {
                          await _databaseService.createNewChat(
                            uid1: _authService.user!.uid,
                            uid2: user.uid!,
                          );
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatPage(chatUser: user),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (__, _) => const SizedBox(height: 10.0),
                );
              }
              return const LoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}
