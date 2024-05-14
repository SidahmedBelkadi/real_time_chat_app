import 'package:chat/core/constants/strings.dart';
import 'package:flutter/material.dart';

class DontHaveAnAccount extends StatelessWidget {
  final VoidCallback onPressed;
  const DontHaveAnAccount({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(kDontHaveAnAccount),
      ),
    );
  }
}
