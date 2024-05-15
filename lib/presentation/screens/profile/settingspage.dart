import 'package:flutter/material.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/presentation/screens/auth/widgets/snackbar.dart';
import 'package:parkr/presentation/screens/profile/widgets/alertdialog.dart';
import 'package:parkr/presentation/screens/profile/widgets/settingswidget.dart';
import 'package:parkr/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

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
            SettingsWidget(
                iconname: Icons.help_outline_rounded, text: 'Help & Support', onTap: () {
                  launchEmail();
                }),
            sizedten(context),
             SettingsWidget(
                iconname: Icons.privacy_tip_outlined, text: 'Privacy Policy', onTap: () {
                  launchUrl(Uri.parse('https://sites.google.com/view/parkwiser-app-privacy-policy/home'), mode: LaunchMode.inAppBrowserView);
                }),
            sizedten(context),
            SettingsWidget(
              iconname: Icons.delete_forever,
              text: 'Delete My Data',
              onTap: () {
                alertdialog(
                    context,
                    const Text('Alert'),
                    const Text(
                        'This will send a request to delete all your data, do you want to continue?'),
                    () {
                  Navigator.of(context).pop();
                  showSnackbar(context, 'Request sent!');
                });
              },
            ),
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

dynamic launchEmail() async {
  try
  {
    Uri email = Uri(
      scheme: 'mailto',
      path: "afradahsan02@gmail.com",
      queryParameters: {
        'subject': "Parkwiser Support"
      },
    );

    await launchUrl(email);
  }
  catch(e) {
    debugPrint(e.toString());
  }
}