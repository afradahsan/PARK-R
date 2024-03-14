import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkr/business_logic/onboarding/bloc/onboarding_bloc.dart';
import 'package:parkr/business_logic/signin/bloc/signin_bloc.dart';
import 'package:parkr/business_logic/signup/bloc/signup_bloc.dart';
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/firebase_options.dart';
import 'package:parkr/presentation/screens/auth/onboarding_page.dart';
import 'package:parkr/presentation/screens/navscreens.dart/bottomnav.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AuthRepo().getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingBloc(),
        ),
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(create: (context) => SigninBloc(context)),
      ],
      builder: (context, child) {
        Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? debugPrint('not empty')
            : debugPrint('empty');
        return MaterialApp(
            title: 'Parkr',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: darkbgColor,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              textTheme: KTextTheme.darkTextTheme,
              useMaterial3: true,
            ),
            home: Builder(
              builder: (context) {
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                return userProvider.user.token.isNotEmpty
                    ? const BottomNav()
                    : SignupPage();
              },
            ));
      },
    );
  }
}
