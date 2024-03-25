import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/admin/pages/addparking.dart';
import 'package:parkr/presentation/screens/admin/pages/adminhome.dart';
import 'package:parkr/presentation/screens/admin/pages/adminpark.dart';
import 'package:parkr/presentation/screens/admin/pages/adminstats.dart';
import 'package:parkr/utils/colors.dart';

class AdminNav extends StatefulWidget {
  const AdminNav({super.key});

  @override
  State<AdminNav> createState() => _AdminNavState();
}

class _AdminNavState extends State<AdminNav> {
  List pages = [];
  int selectedIndex = 0;

  @override
  void initState() {
    pages = [
      const AdminHomePage(),
      const AdminPark(),
      const AdminStats()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          pages[selectedIndex],
          selectedIndex==0 ? Positioned(
            bottom: screenHeight / 10 + 16, // Adjust as needed
            right: 16,
            child: FloatingActionButton(
              backgroundColor: greenColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return AddParking();
                }));
              },
              child: Icon(Icons.add, color: darkbgColor,),
            ),
          ) : const Text('')
        ],
      ),
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
          color: darkbgColor,
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
          backgroundColor: Colors.transparent,
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
