import 'package:flutter/material.dart';
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/utils/constants.dart';
import 'package:provider/provider.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(105, 158, 158, 158)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg')),
            sizedwten(context),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(user.phone,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))
              ],
            ),
            const Spacer(),

          ],
        ),
      ),
    );
  }
}
