import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/home/bookmarks.dart';
import 'package:parkr/presentation/screens/home/homepage.dart';
import 'package:parkr/presentation/screens/home/mybookings.dart';
import 'package:parkr/presentation/screens/profile/profilepage.dart';
import 'package:parkr/utils/colors.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List pages = [];
  int selectedIndex = 0;

  @override
  void initState() {
    pages = [
      const Homepage(),
      const MyBookings(),
      // const Bookmarks(),
      const ProfilePage()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    Widget wdivider = SizedBox(
      width: screenHeight / 130,
    );

    print('navbar: $screenWidth, $screenHeight');
    return Scaffold(
      body: pages[selectedIndex],
      extendBody: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        height: screenHeight / 10,
        width: screenWidth,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: darkbgColor, // Set the color to darkbgColor
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(100, 0, 0, 0),
              blurRadius: 2,
              spreadRadius: 2,
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          enableFeedback: true,
          currentIndex: selectedIndex,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          backgroundColor: Colors.transparent, // Set the color to darkbgColor
          items: [
            BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? Image.asset(
                      'assets/Home-filled.png',
                      height: 30,
                    )
                  : Image.asset('assets/Home-outline.png', height: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 1
                  ? Image.asset(
                      'assets/ticket-filled.png',
                      height: 28,
                    )
                  : Image.asset('assets/ticket-outlined.png', height: 28),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 2
                  ? Image.asset(
                      'assets/profile-filled.png',
                      height: 32,
                    )
                  : Image.asset('assets/profile-outlined.png', height: 32),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
