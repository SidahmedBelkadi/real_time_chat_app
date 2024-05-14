import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController? controller;
  final bool isObsecure;
  const AppFormField({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
    this.isObsecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObsecure,
      decoration: InputDecoration(
        hintText: hint,
        label: Text(label),
      ),
    );
  }
}
