import 'package:chat/core/constants/strings.dart';
import 'package:chat/widgets/app_elevated_button.dart';
import 'package:chat/widgets/login/login_form.dart';
import 'package:chat/widgets/login/login_header.dart';
import 'package:chat/widgets/login/login_wrapper_container.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: LoginWrapperContainer(
            children: [
              LoginHeader(),
              SizedBox(height: 64.0),
              LoginForm(),
              SizedBox(height: 64.0),
              AppElevatedButton(child: Text(kLogin)),
            ],
          ),
        ),
      ),
    );
  }
}
