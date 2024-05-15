import 'package:flutter/material.dart';

class AccountQuestion extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String textButton;
  const AccountQuestion({
    super.key,
    required this.onPressed,
    required this.text,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          TextButton(
            onPressed: onPressed,
            child: Text(textButton),
          ),
        ],
      ),
    );
  }
}
