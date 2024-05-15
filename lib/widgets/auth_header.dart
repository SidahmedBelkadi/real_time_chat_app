import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  const AuthHeader({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          subTitle,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
