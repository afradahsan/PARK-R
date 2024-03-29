import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
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
  final TextEditingController parkingFee = TextEditingController();

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

  void addParking(){

    setState(() {
      isLoading = true; // Set loading state to true when API call starts
    });

    if(addParkingFormKey.currentState!.validate() && image!= null && currentPosition!=null){
      adminRepo.addParking(context: context, image: image!, parkingName: parkingnameController.text, locationName: locationNameCntrlr.text, position: ('${currentPosition!.latitude}, ${currentPosition!.longitude}').toString(), totalSpots: int.parse(totalspots.text), parkingFee: int.parse(parkingFee.text), indoor: indoor, carWash: carWash, evCharge: evCharge);
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
          'Add New Parking Lot',
          style: TextStyle(color: greenColor, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(greenColor)),
            onPressed: (){
            addParking();
          }, child: isLoading
                  ? Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: darkbgColor)))
                  : Text('Save', style: TextStyle(color: darkbgColor),))
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
                TFormAdmin(
                  controller: parkingFee,
                  hintText: 'Parking Fee',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Fee';
                    } else {
                      return null;
                    }
                  },
                  textinputtype: TextInputType.number,
                ),
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
                    const Text('Car Wash'),
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
                    const Text('EV Charging'),
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