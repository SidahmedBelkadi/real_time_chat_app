import 'package:chat/app.dart';
import 'package:chat/utils/dependency_injection/service_locator.dart';
import 'package:chat/utils/firebase/setup.dart';
import 'package:flutter/material.dart';

void main() async {
  await setup();
  runApp(ChatApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerServices();
}
