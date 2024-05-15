import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback onLogoutTap;
  const HomeDrawer({
    super.key,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: GestureDetector(
          onTap: onLogoutTap,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Logout"),
              SizedBox(width: 22.0),
              Icon(Icons.logout),
            ],
          ),
        ),
      ),
    );
  }
}
