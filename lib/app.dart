import 'package:chat/core/theme/app_theme.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/utils/routing/app_router.dart';
import 'package:chat/utils/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class ChatApp extends StatelessWidget {
  final GetIt getIt = GetIt.instance;
  late AuthService _authService;
  ChatApp({super.key}) {
    _authService = getIt.get<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: _authService.user != null ? AppRoutes.home : AppRoutes.login,
      routes: routes,
    );
  }
}
