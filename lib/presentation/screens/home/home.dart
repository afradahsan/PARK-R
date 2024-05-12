import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:parkr/business_logic/cubits/fetchlocation/fetchlocation_cubit.dart';
import 'package:parkr/business_logic/fetch_address/fetchaddress_bloc.dart';
import 'package:parkr/presentation/screens/home/parkinglots.dart';
import 'package:parkr/presentation/screens/home/widgets/nearbylotcontainer.dart';
import 'package:parkr/presentation/screens/home/widgets/searchbar.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // String placemark = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FetchaddressBloc>().add(const FetchEvent());
    });
  }

  // fetch() async {
  //   placemark = await fetchCity(context);
  // }

  @override
  Widget build(BuildContext context) {
    // debugPrint('addd${placemark.toString()}');
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Searchbar(
              controller: searchController,
            ),
            sizedtwenty(context),
            Text(
              'Parking Lot Nearby',
              style: KTextTheme.darkTextTheme.titleMedium,
            ),
            sizedten(context),
            const NearbyLots(),
            sizedtwenty(context),
            Text(
              'Services',
              style: KTextTheme.darkTextTheme.titleMedium,
            ),
            sizedten(context),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const ParkingLots();
                  },
                ));
              },
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: whitet150),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_parking,
                      size: 40,
                      color: white,
                    ),
                    Text(
                      'Book a Parking',
                      style: KTextTheme.darkTextTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Lottie.asset('assets/animations/location_lottie.json'),
            )
          ],
        ),
      )),
    );
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: BlocBuilder<FetchaddressBloc, FetchaddressState>(
      builder: (context, state) {
        if (state is FetchaddressLoading) {
          debugPrint('loading');
          return Lottie.asset('assets/animations/location_lottie.json',
              height: 50);
        } else if (state is FetchaddressError) {
          debugPrint('load');
          return Text('Error');
        } else if (state is FetchaddressSuccess) {
          return Row(children: [
            Icon(
              Icons.location_on,
              color: greenColor,
              size: 18,
            ),
            sizedwfive(context),
            Text(
              state.address,
              style: KTextTheme.darkTextTheme.bodyLarge,
            )
          ]);
        } else {
          debugPrint('else');
          return Text('data');
        }
      },
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_rounded,
            color: white,
            size: 20,
          ))
    ],
  );
}

Future<Position> fetchPosition(BuildContext context) async {
  final position = await context.read<FetchlocationCubit>().determinePosition();
  debugPrint('Position: ${position.toString()}');
  return position;
}
