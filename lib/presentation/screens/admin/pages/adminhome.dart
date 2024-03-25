import 'package:flutter/material.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
import 'package:parkr/presentation/screens/admin/widgets/parkingadmincontainer.dart';
import 'package:parkr/presentation/screens/home/widgets/loader.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final AdminRepo adminRepo = AdminRepo();
  List<ParkingModel>? parkinglotList;

  @override
  void initState() {
    super.initState();
    fetchAllParkingLots();
  }

  fetchAllParkingLots() async {
    parkinglotList = await adminRepo.fetchParkingLots(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return parkinglotList == null
        ? const Loader()
        : Scaffold(
            appBar: AppBar(
              title: Text('Hello, Admin!',
                  style: TextStyle(color: greenColor, fontSize: 18)),
              iconTheme: IconThemeData(color: greenColor),
              backgroundColor: darkbgColor,
              elevation: 0,
              actions: const [Icon(Icons.search)],
            ),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ParkingAdminContainer(
                      parkinglotList: parkinglotList!, index: index);
                },
                itemCount: parkinglotList!.length,
                separatorBuilder: (context, index) {
                  return sizedten(context);
                },
              ),
            )),
          );
  }
}
