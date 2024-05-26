import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parkr/data/models/vehiclemodel.dart';
import 'package:parkr/data/repositories/myvehicles/myvehicle_repo.dart';
import 'package:parkr/presentation/screens/profile/addvehicle.dart';
import 'package:parkr/presentation/screens/profile/widgets/vehiclecontainer.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:parkr/utils/themes.dart';

class MyVehicles extends StatefulWidget {
  const MyVehicles({super.key});

  @override
  State<MyVehicles> createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {
  List<Vehicle> vehicleList = [];

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  void fetchVehicles() async {
    List<Vehicle> fetchedVehicles = await MyVehicleRepo().getVehicles(context);
    setState(() {
      vehicleList = fetchedVehicles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'My Vehicles',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const AddVehicle();
              }));
            },
            backgroundColor: greenColor,
            child: Icon(
              Icons.add,
              color: darkbgColor,
            )), 
        body: SafeArea(
            child: vehicleList.isEmpty ? SizedBox(
                    width: double.maxFinite,
                    height: 600,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/7317981.png',
                          height: 180,
                        ),
                        Text(
                          'No Vehicles Found!',
                          style: KTextTheme.darkwhiteTextTheme.titleMedium,
                        ),
                        sizedfive(context),
                        Text(
                          'Tap on \'+\' to add a new vehicle',
                          style: KTextTheme.darkTextTheme.bodyMedium,
                        ),
                        sizedten(context),
                      ],
                    ),
                  ) : ListView.separated(
          padding: const EdgeInsets.all(15),
          itemCount: vehicleList.length,
          separatorBuilder: (context, index) {
            return sizedten(context);
          },
          itemBuilder: (context, index) {
            return VehicleContainer(
                image: vehicleList[index].vehicleType == 'Four Wheeler'
                    ? 'assets/audi-q3.png'
                    : 'assets/himalayan_411.jpg',
                modelName: vehicleList[index].vehicleName,
                regNo: vehicleList[index].vehicleNumber, vehicle: vehicleList[index],);
          },
        )));
  }
}
