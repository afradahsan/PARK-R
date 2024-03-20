import 'package:flutter/material.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
import 'package:parkr/presentation/screens/home/widgets/loader.dart';
import 'package:parkr/presentation/screens/home/widgets/parkinglotcontainer.dart';
import 'package:parkr/utils/colors.dart';

class ParkingLots extends StatefulWidget {
  const ParkingLots({super.key});

  @override
  State<ParkingLots> createState() => _ParkingLotsState();
}

class _ParkingLotsState extends State<ParkingLots> {
  final AdminRepo adminRepo = AdminRepo();
  List<ParkingModel>? parkinglotList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllParkingLots();
  }

  fetchAllParkingLots() async{
    parkinglotList = await adminRepo.fetchParkingLots(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return parkinglotList == null ? Loader() : Scaffold(
      appBar: AppBar(
        title: Text('Parking Lots near you!', style:TextStyle(color: greenColor, fontSize: 18)),
        iconTheme: IconThemeData(color: greenColor),
        backgroundColor: darkbgColor,
        elevation: 0,
        actions: [
          Icon(Icons.search)
        ],
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(itemBuilder: (context, index) {
          return ParkingLotContainer(parkinglotList: parkinglotList!, index: index);
        }, itemCount: 1,),
      )),
    );
  }
}