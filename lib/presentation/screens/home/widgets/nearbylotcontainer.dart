import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkr/business_logic/cubits/choicechip/choicechip.dart';
import 'package:parkr/business_logic/parkingdetails/parkingdetails_bloc.dart';
import 'package:parkr/data/models/parkingmodel.dart';
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
            if(state is ParkingdetailsInitial){
              context.read<ParkingdetailsBloc>().add( ParkingdescEvent());
              return CircularProgressIndicator(color: greenColor,);
            } else if(state is ParkingDetailsLoadingState){
              return CircularProgressIndicator(color: white,);
            } else if(state is ParkingDetailsSuccessState){
              parkinglist = state.parkingList;
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
                  return Stack(
                        children: [
                          Container(
                            height: 200,
                            width: screenW(context) - 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(parkinglist[index].image),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      parkinglist[index].parkingName,
                                      style: KTextTheme.darkTextTheme.bodyLarge,
                                    ),
                                    Text(
                                      parkinglist[index].locationName,
                                      style: TextStyle(color: whitet150, fontSize: 12),
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
                                            Text('0.6KM')
                                          ],
                                        ),
                                        const Spacer(),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: context.watch<BikeChoiceChipCubit>().state ? '₹${parkinglist[index].bikeparkingFee.toString()}' : context.watch<CarChoiceChipCubit>().state ? '₹${parkinglist[index].carparkingFee.toString()}' : '₹${parkinglist[index].truckparkingFee.toString()}',
                                              style: TextStyle(
                                                  color: greenColor,
                                                  fontSize: 16,
                                                  fontFamily: GoogleFonts.montserrat()
                                                      .fontFamily)),
                                          TextSpan(
                                              text: '/hr',
                                              style: TextStyle(
                                                  color: whitet150,
                                                  fontSize: 12,
                                                  fontFamily: GoogleFonts.montserrat()
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
                  );
                }
              ),
            );
          } else if (state is ParkingDetailsErrorState){
            return Text('error');
          } else {
            return Text('data error');
          }
          }
        );
  }
}
