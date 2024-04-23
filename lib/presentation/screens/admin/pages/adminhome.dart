import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkr/business_logic/cubits/appproveparking/approveparking_cubit.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
import 'package:parkr/presentation/screens/admin/widgets/approveparking.dart';
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
    debugPrint('fetched.');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return parkinglotList == null
        ? const Loader(
            appbartext: 'Hello, Admin',
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Hello, Admin!',
                  style: TextStyle(color: greenColor, fontSize: 18)),
              backgroundColor: darkbgColor,
              elevation: 0,
            ),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  debugPrint('list: $parkinglotList');
                  if (parkinglotList![index].approved == true) {
                    return ParkingAdminContainer(
                        parkinglotList: parkinglotList!, index: index);
                  } else {
                    debugPrint('approve brooo');
                    return ApproveParking(
                          parkinglotList: parkinglotList!,
                          index: index,
                          cubit: context.read<ApproveParkingCubit>(),
                        );
                  }
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