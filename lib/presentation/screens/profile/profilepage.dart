import 'package:flutter/material.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/presentation/screens/profile/myvehicles.dart';
import 'package:parkr/presentation/screens/profile/widgets/profilecontainer.dart';
import 'package:parkr/presentation/screens/profile/widgets/profilelistwidget.dart';
import 'package:parkr/utils/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            sizedten(context),
            const ProfileContainer(),
            sizedtwenty(context),
            const ProfileListWidget(
              iconname: Icons.directions_car_rounded,
              text: 'My Vehicles',
              returnpage: MyVehicles(),
            ),
            sizedten(context),
            const ProfileListWidget(iconname: Icons.wallet, text: 'Wallet'),
            sizedten(context),
            const ProfileListWidget(
                iconname: Icons.compare_arrows_rounded,
                text: 'Transaction History'),
            sizedten(context),
            const ProfileListWidget(iconname: Icons.discount, text: 'Coupons'),
            sizedten(context),
            const ProfileListWidget(iconname: Icons.settings, text: 'Settings'),
            sizedtwenty(context),
            ElevatedButton.icon(
                onPressed: () {
                  AuthRepo().logOut(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'))
          ],
        ),
      )),
    );
  }
}
