import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController? controller;
  final bool isObsecure;
  final RegExp validationRegExp;

  const AppFormField({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
    this.isObsecure = false,
    required this.validationRegExp,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObsecure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value != null && validationRegExp.hasMatch(value)) {
          return null;
        }
        return "Enter a valid ${hint.toLowerCase()}";
      },
      decoration: InputDecoration(
        hintText: hint,
        label: Text(label),
      ),
    );
  }
}
