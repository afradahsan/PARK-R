import 'package:flutter/material.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/presentation/screens/admin/pages/addparking.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                AuthRepo().logOut(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log Out')),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddParking();
                }));
              },
              icon: const Icon(Icons.logout),
              label: const Text('Add Parking Lot'))
        ],
      )),
    );
  }
}
