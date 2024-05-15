import 'package:flutter/material.dart';

class SimpleErrorWidget extends StatelessWidget {
  const SimpleErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Unable to load Data",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
