import 'package:chat/app.dart';
import 'package:chat/utils/firebase/setup.dart';
import 'package:flutter/material.dart';

void main() async {
  await setup();
  runApp(const ChatApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
}
