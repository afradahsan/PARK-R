import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/totalprice_cubit/totalprice_cubit.dart';
import 'package:parkr/business_logic/parkingdetails/parkingdetails_bloc.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class TotalPayContainer extends StatelessWidget {
  const TotalPayContainer({super.key, required this.index, required this.vehicleType, required this.wash,});

  final int index;
  final String vehicleType;
  final bool wash;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 160,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: whitet50, borderRadius: BorderRadius.circular(15)),
      child: BlocBuilder<ParkingdetailsBloc, ParkingdetailsState>(
        builder: (context, state) {
          if(state is ParkingDetailsLoadingState){
            return CircularProgressIndicator();
          } else if (state is ParkingDetailsErrorState){
            return const Text('Error: Failed to load parking details');
          }
          else if (state is ParkingDetailsSuccessState){
            final int parkingfee = vehicleType == 'Four Wheeler' ? state.parkingList[index].carparkingFee : state.parkingList[index].bikeparkingFee;
            final int total = parkingfee + state.parkingList[index].carwashFee!;

            BlocProvider.of<TotalpriceCubit>(context).updateTotalPrice(total);

          return Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Parking Fee',
                      style: KTextTheme.darkwhiteTextTheme.titleMedium,
                    ),
                    const Spacer(),
                    Text( '₹${parkingfee.toString()}',
                      style: TextStyle(
                          color: whitet200,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                sizedfive(context),
                wash ? Row(
                  children: [
                    Text(
                      'Complete Car Wash',
                      style: KTextTheme.darkwhiteTextTheme.titleMedium,
                    ),
                    sizedwfive(context),
                    Icon(
                      Icons.verified,
                      color: greenColor,
                      size: 20,
                    ),
                    const Spacer(),
                    Text(
                     '₹${state.parkingList[index].carwashFee.toString()}',
                      style: TextStyle(
                          color: whitet200,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ) : sizedfive(context),
                sizedten(context),
                Container(
                  height: 2,
                  width: double.maxFinite,
                  color: whitet150,
                ),
                sizedten(context),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: KTextTheme.darkwhiteTextTheme.titleMedium,
                    ),
                    const Spacer(),
                    Text(
                      '₹${total.toString()}',
                      style: TextStyle(
                          color: whitet200,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                    
                  ],
                ),
              ],
            );} else {
              return CircularProgressIndicator(color: white,);
            }
        },
      ),
    );
  }
}
