import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkr/business_logic/bookings_bloc/bookings_bloc.dart';
import 'package:parkr/business_logic/cubits/addparking_cubit/addparking_cubit.dart';
import 'package:parkr/business_logic/cubits/appproveparking/approveparking_cubit.dart';
import 'package:parkr/business_logic/cubits/choicechip/choicechip.dart';
import 'package:parkr/business_logic/cubits/fetchlocation/fetchlocation_cubit.dart';
import 'package:parkr/business_logic/cubits/selectvehindex/selectvehindex_cubit.dart';
import 'package:parkr/business_logic/cubits/showtruck/showtruckcubit.dart';
import 'package:parkr/business_logic/cubits/totalprice_cubit/totalprice_cubit.dart';
import 'package:parkr/business_logic/cubits/wash/wash_cubit.dart';
import 'package:parkr/business_logic/myvehicles/myvehicles_bloc.dart';
import 'package:parkr/business_logic/onboarding/bloc/onboarding_bloc.dart';
import 'package:parkr/business_logic/parkingdetails/parkingdetails_bloc.dart';
import 'package:parkr/business_logic/signin/bloc/signin_bloc.dart';
import 'package:parkr/business_logic/signup/bloc/signup_bloc.dart';
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/data/repositories/auth_repo.dart';
import 'package:parkr/firebase_options.dart';
import 'package:parkr/presentation/screens/auth/splashscreen.dart';
import 'package:parkr/presentation/screens/home/homepage.dart';
import 'package:parkr/presentation/screens/home/parkinglots.dart';
import 'package:parkr/utils/buttontheme.dart';
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
        BlocProvider(
          create: (context) => ParkingdetailsBloc(context),
        ),
        BlocProvider(
          create: (context) => MyvehiclesBloc(context),
        ),
        BlocProvider(
          create: (context) => SelectvehindexCubit(),
        ),
        BlocProvider(
          create: (context) => WashCubit(),
        ),
        BlocProvider(
          create: (context) => IndoorCubit(),
        ),
        BlocProvider(
          create: (context) => CarWashCubit(),
        ),
        BlocProvider(
          create: (context) => EvChargeCubit(),
        ),
        BlocProvider(
          create: (context) => BookingsBloc(),
        ),
        BlocProvider(
          create: (context) => TotalpriceCubit(),
        ),
        BlocProvider(
          create: (context) => ApproveParkingCubit(),
        ),
        BlocProvider(
          create: (context) => BikeChoiceChipCubit(),
        ),
        BlocProvider(
          create: (context) => CarChoiceChipCubit(),
        ),
        BlocProvider(
          create: (context) => TruckChoiceChipCubit(),
        ),
        BlocProvider(
          create: (context) => ShowTruckCubit(),
        ),
        BlocProvider(
          create: (context) => FetchlocationCubit(),
        )
      ],
      builder: (context, child) {
        Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context, listen: false).user.type ==
                    'user'
                ? debugPrint('user')
                : debugPrint('not empty')
            : debugPrint('empty');
        return MaterialApp(
            title: 'Parkr',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
              }),
              canvasColor: Colors.transparent,
                scaffoldBackgroundColor: darkbgColor,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                textTheme: KTextTheme.darkTextTheme,
                useMaterial3: true,
                elevatedButtonTheme: kButtonTheme.elevatedButtonTheme),
            routes: {
              '/home': (context) => const Homepage(),
              '/parkinglots': (context) => const ParkingLots()
            },
            home: const SplashScreen());
      },
    );
  }
}