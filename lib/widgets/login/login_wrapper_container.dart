import 'package:flutter/material.dart';

class LoginWrapperContainer extends StatelessWidget {
  final List<Widget> children;
  const LoginWrapperContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
