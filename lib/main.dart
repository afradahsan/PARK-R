import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkr/firebase_options.dart';
import 'package:parkr/presentation/screens/auth/signup_page.dart';
import 'package:parkr/presentation/screens/auth/splashscreen.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: darkbgColor,
        fontFamily: GoogleFonts.montserrat().fontFamily,
        textTheme: KTextTheme.darkTextTheme,
        useMaterial3: true,
      ),
      home: SignupPage()
    );
  }
}