import 'package:flutter/material.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/presentation/screens/profile/widgets/settingswidget.dart';
import 'package:parkr/utils/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            sizedtwenty(context),
            const SettingsWidget(
                iconname: Icons.help_outline_rounded, text: 'Help & Support'),
            sizedten(context),
            const SettingsWidget(
                iconname: Icons.privacy_tip_outlined, text: 'Privacy Policy'),
            sizedten(context),
            SettingsWidget(
                iconname: Icons.delete_forever, text: 'Delete My Data', onTap: () {
                  showDialog(context: context, builder: (context) {
                    return Dialog();
                  },);
                },),
                sizedten(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      AuthRepo().logOut(context);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Log Out')),
              ],
            )
                    ],
                  ),
          )),
    );
  }
}
