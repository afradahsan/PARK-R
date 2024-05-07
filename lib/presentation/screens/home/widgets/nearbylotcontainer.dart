import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkr/business_logic/cubits/choicechip/choicechip.dart';
import 'package:parkr/business_logic/cubits/fetchlocation/fetchlocation_cubit.dart';
import 'package:parkr/business_logic/parkingdetails/parkingdetails_bloc.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/presentation/screens/parking/parkingdetails.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class NearbyLots extends StatelessWidget {
  const NearbyLots({super.key});

  @override
  Widget build(BuildContext context) {
    List<ParkingModel> parkinglist = [];
    return BlocBuilder<ParkingdetailsBloc, ParkingdetailsState>(
        builder: (context, state) {
      if (state is ParkingdetailsInitial) {
        context.read<ParkingdetailsBloc>().add(ParkingdescEvent());
        return CircularProgressIndicator(
          color: greenColor,
        );
      } else if (state is ParkingDetailsLoadingState) {
        return CircularProgressIndicator(
          color: white,
        );
      } else if (state is ParkingDetailsSuccessState) {
        parkinglist = state.parkingList;
        return FutureBuilder(
            future: fetchPosition(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(color: white);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final position = snapshot.data!;
                return SizedBox(
                  height: 200,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return sizedwten(context);
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: parkinglist.length,
                      itemBuilder: (context, index) {
                        List<double> distanceIterable = [];
                        for (int i = 0; i < parkinglist.length; i++) {
                          List<double> pos =
                              splitPosition(parkinglist[i].position);
                          double endLatitude = pos[0];
                          double endLongitude = pos[1];
                          final distance = distanceBetween(position.latitude,
                              position.longitude, endLatitude, endLongitude);
                          distanceIterable.add(distance);
                        }

                        // Find minimum distance
                        double minDistance = distanceIterable.isNotEmpty
                            ? distanceIterable.reduce((value, element) =>
                                value < element ? value : element)
                            : double.infinity;

                        // Sort parking list based on distance
                        parkinglist.sort((a, b) {
                          List<double> posA = splitPosition(a.position);
                          List<double> posB = splitPosition(b.position);
                          double endLatitudeA = posA[0];
                          double endLongitudeA = posA[1];
                          double endLatitudeB = posB[0];
                          double endLongitudeB = posB[1];
                          final distanceA = distanceBetween(position.latitude,
                              position.longitude, endLatitudeA, endLongitudeA);
                          final distanceB = distanceBetween(position.latitude,
                              position.longitude, endLatitudeB, endLongitudeB);
                          return distanceA.compareTo(distanceB);
                        });

                        double startLatitude = position.latitude;
                        double startLongitude = position.longitude;
                        List<double> pos =
                            splitPosition(parkinglist[index].position);
                        double endLatitude = pos[0];
                        double endLongitude = pos[1];
                        final distance = distanceBetween(startLatitude,
                            startLongitude, endLatitude, endLongitude);
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return ParkingDetails(index: index);
                            },));
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                width: screenW(context) - 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            parkinglist[index].image),
                                        fit: BoxFit.cover),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.4),
                                          offset: const Offset(2, 2),
                                          spreadRadius: 2,
                                          blurRadius: 7)
                                    ],
                                    color: whitet50,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: screenW(context) - 100,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      color: darkbgColor,
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          parkinglist[index].parkingName,
                                          style:
                                              KTextTheme.darkTextTheme.bodyLarge,
                                        ),
                                        Text(
                                          parkinglist[index].locationName,
                                          style: TextStyle(
                                              color: whitet150, fontSize: 12),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.location_fill,
                                                  size: 15,
                                                  color: whitet200,
                                                ),
                                                sizedwfive(context),
                                                Text(
                                                    '${(distance / 1000).toStringAsFixed(2)}KM')
                                              ],
                                            ),
                                            const Spacer(),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: context
                                                          .watch<
                                                              BikeChoiceChipCubit>()
                                                          .state
                                                      ? '₹${parkinglist[index].bikeparkingFee.toString()}'
                                                      : context
                                                              .watch<
                                                                  CarChoiceChipCubit>()
                                                              .state
                                                          ? '₹${parkinglist[index].carparkingFee.toString()}'
                                                          : '₹${parkinglist[index].truckparkingFee.toString()}',
                                                  style: TextStyle(
                                                      color: greenColor,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          GoogleFonts.montserrat()
                                                              .fontFamily)),
                                              TextSpan(
                                                  text: '/hr',
                                                  style: TextStyle(
                                                      color: whitet150,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          GoogleFonts.montserrat()
                                                              .fontFamily))
                                            ]))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }
              return Text('no data');
            });
      } else if (state is ParkingDetailsErrorState) {
        return Text('error');
      } else {
        return Text('data error');
      }
    });
  }

  Future<Position> fetchPosition(BuildContext context) async {
    final position =
        await context.read<FetchlocationCubit>().determinePosition();
    debugPrint('Position: ${position.toString()}');
    return position;
  }

  List<double> splitPosition(String position) {
    List<String> parts = position.split(', ');

    double latitude = double.tryParse(parts[0]) ?? 0.0;
    double longitude = double.tryParse(parts[1]) ?? 0.0;

    List<double> latlon = [latitude, longitude];
    return latlon;
  }

  double distanceBetween(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }
}
