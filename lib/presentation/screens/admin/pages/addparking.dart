import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkr/business_logic/cubits/addparking_cubit/addparking_cubit.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
import 'package:parkr/presentation/screens/admin/widgets/animatedcarwashcontainer.dart';
import 'package:parkr/presentation/screens/admin/widgets/checkboxes.dart';
import 'package:parkr/presentation/screens/admin/widgets/parkingfeecontainer.dart';
import 'package:parkr/presentation/screens/admin/widgets/pickimage.dart';
import 'package:parkr/presentation/screens/admin/widgets/pickimagecontainer.dart';
import 'package:parkr/presentation/screens/admin/widgets/tformadmin.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/permissions.dart';

class AddParking extends StatefulWidget {
  AddParking({super.key});

  @override
  State<AddParking> createState() => _AddParkingState();
}

class _AddParkingState extends State<AddParking> {
  String? currentAddress;
  Position? currentPosition;
  final TextEditingController parkingnameController = TextEditingController();
  final TextEditingController locationNameCntrlr = TextEditingController();
  final TextEditingController totalspots = TextEditingController();
  final TextEditingController availspots = TextEditingController();
  final TextEditingController carparkingFee = TextEditingController();
  final TextEditingController bikeparkingFee = TextEditingController();
  final TextEditingController truckparkingFee = TextEditingController();
  final TextEditingController? carwashFee = TextEditingController();

  final AdminRepo adminRepo = AdminRepo();
  final addParkingFormKey = GlobalKey<FormState>();

  bool carWash = false;
  bool evCharge = false;
  bool security = false;
  bool wheelchair = false;
  bool indoor = false;
  bool isLoading = false;

  File? image;

  void selectImages() async {
    image = await pickImages();
  }

  void addParking() {
    setState(() {
      isLoading = true; // Set loading state to true when API call starts
    });

    if (addParkingFormKey.currentState!.validate() &&
        image != null &&
        currentPosition != null) {
      adminRepo.addParking(
          context: context,
          image: image!,
          parkingName: parkingnameController.text,
          locationName: locationNameCntrlr.text,
          position:
              ('${currentPosition!.latitude}, ${currentPosition!.longitude}')
                  .toString(),
          totalSpots: int.parse(totalspots.text),
          carparkingFee: int.parse(carparkingFee.text),
          bikeparkingFee: int.parse(bikeparkingFee.text),
          truckparkingFee: int.parse(truckparkingFee.text),
          carwashFee: carwashFee==null ? int.parse(carwashFee!.text) : 0,
          indoor: indoor,
          carWash: carWash,
          evCharge: evCharge);
          debugPrint('done creating.');
    } else {
      debugPrint('Nulll');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        shadowColor: Colors.transparent,
        surfaceTintColor: greenColor,
        foregroundColor: greenColor,
        iconTheme: IconThemeData(color: greenColor),
        title: Text(
          'Add New Parking Lot',
          style: TextStyle(color: greenColor, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(greenColor)),
              onPressed: () {
                addParking();
              },
              child: isLoading
                  ? Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: darkbgColor)))
                  : Text(
                      'Save',
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
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                image == null
                    ? GestureDetector(
                        onTap: selectImages, child: const PickImageContainer())
                    : Image.file(
                        image!,
                        fit: BoxFit.cover,
                        height: size.height / 4,
                      ),
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
                ParkingFeeContainer(carparkingFee: carparkingFee, bikeparkingFee: bikeparkingFee, truckparkingFee: truckparkingFee,),
                sizedten(context),
                BlocBuilder<CarWashCubit, bool>(
                  builder: (context, state) {
                    return AnimCarWash(state: state, washingFee: carwashFee!);
                  },
                ),
                sizedfive(context),
                CheckBoxes(),         
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
