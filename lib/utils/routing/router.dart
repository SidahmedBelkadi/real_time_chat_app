import 'package:chat/pages/home_page.dart';
import 'package:chat/pages/login.dart';
import 'package:chat/utils/routing/app_router.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.login: (context) => const LoginPage(),
  AppRoutes.home: (context) => const HomePage(),
};
