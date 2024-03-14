import 'package:flutter/material.dart';
import 'package:parkr/data/repositories/auth_repo.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton.icon(
            onPressed: () {
              AuthRepo().logOut(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log Out')
          )
        )
      ),
    );
  }
}