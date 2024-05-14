import 'package:chat/core/constants/strings.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          kLoginHeaderTitle,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          kLoginHeaderSubTitle,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
