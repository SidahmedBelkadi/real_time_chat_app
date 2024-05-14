import 'package:chat/core/constants/form.dart';
import 'package:chat/widgets/app_form_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        children: [
          AppFormField(
            hint: kEmail,
            label: kEmail,
            controller: null,
          ),
          SizedBox(height: 16.0),
          AppFormField(
            hint: kPassword,
            label: kPassword,
            controller: null,
          ),
        ],
      ),
    );
  }
}
