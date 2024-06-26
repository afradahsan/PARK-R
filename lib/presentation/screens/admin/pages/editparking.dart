import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkr/business_logic/cubits/addparking_cubit/addparking_cubit.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
import 'package:parkr/presentation/screens/admin/widgets/animatedcarwashcontainer.dart';
import 'package:parkr/presentation/screens/admin/widgets/checkboxes.dart';
import 'package:parkr/presentation/screens/admin/widgets/parkingfeecontainer.dart';
import 'package:parkr/presentation/screens/admin/widgets/pickimage.dart';
import 'package:parkr/presentation/screens/admin/widgets/tformadmin.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/permissions.dart';

class EditParking extends StatefulWidget {
  const EditParking(
      {super.key, required this.parkinglotList, required this.index});

  final List<ParkingModel> parkinglotList;
  final int index;

  @override
  State<EditParking> createState() => _EditParkingState();
}

class _EditParkingState extends State<EditParking> {
  String? currentAddress;
  Position? currentPosition;
  late TextEditingController parkingnameController;
  late TextEditingController locationNameCntrlr;
  late TextEditingController totalspots;
  late TextEditingController availspots;
  late TextEditingController carparkingFee;
  late TextEditingController bikeparkingFee;
  late TextEditingController truckparkingFee;
  late TextEditingController carwashFee;
  late TextEditingController bikewashFee;

  final AdminRepo adminRepo = AdminRepo();
  final addParkingFormKey = GlobalKey<FormState>();

  bool carWash = false;
  bool evCharge = false;
  bool security = false;
  bool wheelchair = false;
  bool indoor = false;
  bool isLoading = false;

  File? image;

  @override
  void initState() {
    super.initState();
    parkingnameController = TextEditingController(
        text: widget.parkinglotList[widget.index].parkingName);
    locationNameCntrlr = TextEditingController(
        text: widget.parkinglotList[widget.index].locationName);

    totalspots = TextEditingController(
        text: widget.parkinglotList[widget.index].totalSpots.toString());
    carparkingFee = TextEditingController(
        text: widget.parkinglotList[widget.index].carparkingFee.toString());

    carWash = widget.parkinglotList[widget.index].carWash;
    evCharge = widget.parkinglotList[widget.index].evCharge;
    indoor = widget.parkinglotList[widget.index].indoor;
  }

  void selectImages() async {
    image = await pickImages();
  }

  void editParking() {
    setState(() {
      isLoading = true;
    });

    if (addParkingFormKey.currentState!.validate()) {
      adminRepo.editParking(
          context: context,
          id: widget.parkinglotList[widget.index].id!,
          parkingName: parkingnameController.text,
          locationName: locationNameCntrlr.text,
          position: currentPosition == null
              ? widget.parkinglotList[widget.index].position
              : currentPosition.toString(),
          totalSpots: int.parse(totalspots.text),
          carparkingFee: int.parse(carparkingFee.text),
          bikeparkingFee: int.parse(bikeparkingFee.text),
          truckparkingFee: int.parse(truckparkingFee.text),
          carwashFee: int.parse(carwashFee.text),
          bikewashFee: int.parse(bikewashFee.text),
          indoor: indoor,
          carWash: carWash,
          evCharge: evCharge);
    } else {
      debugPrint('Nulll');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        surfaceTintColor: greenColor,
        foregroundColor: greenColor,
        iconTheme: IconThemeData(color: greenColor),
        title: Text(
          'Edit Details',
          style: TextStyle(color: greenColor, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(greenColor)),
              onPressed: () {
                editParking();
              },
              child: isLoading
                  ? Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: darkbgColor)))
                  : Text(
                      'Update',
                      style: TextStyle(color: darkbgColor),
                    ))
        ],
      ),
      body: SafeArea(
          child: Form(
        key: addParkingFormKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                GestureDetector(
                    onTap: selectImages,
                    child: Stack(
                      children: [
                        image == null
                            ? Image.network(
                                widget.parkinglotList[widget.index].image,
                                fit: BoxFit.cover,
                                height: size.height / 4,
                              )
                            : Image.file(
                                image!,
                                fit: BoxFit.cover,
                                height: size.height / 4,
                              ),
                        const Positioned(
                            top: 90,
                            right: 60,
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.grey,
                            ))
                      ],
                    )),
                sizedten(context),
                TFormAdmin(
                  controller: parkingnameController,
                  hintText: 'Parking Lot Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a Name';
                    } else {
                      return null;
                    }
                  },
                ),
                sizedten(context),
                TFormAdmin(
                  controller: locationNameCntrlr,
                  hintText: 'Location Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Location Details';
                    } else {
                      return null;
                    }
                  },
                ),
                sizedten(context),
                GestureDetector(
                  onTap: () {
                    getCurrentPosition(context);
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: size.height / 14,
                    decoration: BoxDecoration(
                        border: Border.all(color: greenColor),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: greenColor,
                        ),
                        const Text(
                          'Choose Location',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                sizedten(context),
                TFormAdmin(
                  controller: totalspots,
                  hintText: 'Total Spots',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Total No. of Spots';
                    } else {
                      return null;
                    }
                  },
                  textinputtype: TextInputType.number,
                ),
                sizedten(context),
                ParkingFeeContainer(
                    carparkingFee: carparkingFee,
                    bikeparkingFee: bikeparkingFee,
                    truckparkingFee: truckparkingFee),
                sizedten(context),
                BlocBuilder<CarWashCubit, bool>(
                  builder: (context, state) {
                    return AnimCarWash(state: state, carWashFee: carwashFee, bikeWashFee: bikewashFee,);
                  },
                ),
                sizedfive(context),
                CheckBoxes(),
                Row(
                  children: [
                    Checkbox(
                        checkColor: darkbgColor,
                        activeColor: greenColor,
                        value: indoor,
                        onChanged: ((value) {
                          setState(() {
                            indoor = value!;
                          });
                        })),
                    Text('Indoor Parking'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        checkColor: darkbgColor,
                        activeColor: greenColor,
                        value: carWash,
                        onChanged: ((value) {
                          setState(() {
                            carWash = value!;
                          });
                        })),
                    Text('Car Wash'),
                    sizedwten(context),
                    Checkbox(
                        checkColor: darkbgColor,
                        activeColor: greenColor,
                        value: evCharge,
                        onChanged: ((value) {
                          setState(() {
                            evCharge = value!;
                          });
                        })),
                    Text('EV Charging'),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> getCurrentPosition(BuildContext context) async {
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        debugPrint('cPos: ${currentPosition.toString()}');
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}