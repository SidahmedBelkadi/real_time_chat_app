import 'package:chat/core/constants/form.dart';
import 'package:chat/core/constants/validation.dart';
import 'package:chat/widgets/app_form_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppFormField(
            hint: kEmail,
            label: kEmail,
            controller: emailController,
            validationRegExp: emailValidationRegex,
          ),
          const SizedBox(height: 16.0),
          AppFormField(
            hint: kPassword,
            label: kPassword,
            controller: passwordController,
            isObsecure: true,
            validationRegExp: passwordValidtionRegex,
          ),
        ],
      ),
    );
  }
}
