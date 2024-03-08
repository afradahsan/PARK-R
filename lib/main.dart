import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkr/business_logic/onboarding/bloc/onboarding_bloc.dart';
import 'package:parkr/business_logic/signin/bloc/signin_bloc.dart';
import 'package:parkr/business_logic/signup/bloc/signup_bloc.dart';
import 'package:parkr/firebase_options.dart';
import 'package:parkr/presentation/screens/auth/onboarding_page.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingBloc(),
        ),
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(create: (context) => SigninBloc())
      ],
      child: MaterialApp(
        title: 'Parkr',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: darkbgColor,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          textTheme: KTextTheme.darkTextTheme,
          useMaterial3: true,
        ),
        home: SignupPage()
      ),
    );
  }
}