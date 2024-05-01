import 'package:flutter/material.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/data/providers/user_provider.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
import 'package:parkr/presentation/screens/admin/widgets/parkingadmincontainer.dart';
import 'package:parkr/presentation/screens/home/widgets/loader.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';
import 'package:provider/provider.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({super.key});

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  final AdminRepo adminRepo = AdminRepo();
  List<ParkingModel>? parkinglotList;

  @override
  void initState() {
    super.initState();
    fetchAllParkingLots();
  }

  fetchAllParkingLots() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final String ownerId = userProvider.user.id;
      debugPrint('ownerId: $ownerId');
      parkinglotList =
          await adminRepo.fetchParkingLotsForOwner(context, ownerId);
      debugPrint('pl: $parkinglotList');
      debugPrint('fetched.');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return parkinglotList == null
        ? const Loader(
            appbartext: 'Hello, Parking Lot Owner',
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text('Your Parking Lots!',
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