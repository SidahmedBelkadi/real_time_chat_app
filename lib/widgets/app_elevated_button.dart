import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const AppElevatedButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: child,
      ),
    );
  }
}
