import 'package:flutter/material.dart';
import 'package:parkr/data/models/parkingmodel.dart';
import 'package:parkr/data/repositories/admin/admin_repo.dart';
import 'package:parkr/presentation/screens/home/widgets/bikechoicechip.dart';
import 'package:parkr/presentation/screens/home/widgets/carchoicechip.dart';
import 'package:parkr/presentation/screens/home/widgets/loader.dart';
import 'package:parkr/presentation/screens/home/widgets/parkinglotcontainer.dart';
import 'package:parkr/presentation/screens/home/widgets/truckchoicechip.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

class SearchRes extends StatefulWidget {
  final String? searchQuery;

  const SearchRes({Key? key, this.searchQuery}) : super(key: key);

  @override
  State<SearchRes> createState() => _SearchResState();
}

class _SearchResState extends State<SearchRes> {
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

  List<ParkingModel>? getFilteredParkingLots() {
    if (widget.searchQuery == null || widget.searchQuery!.isEmpty) {
      return parkinglotList;
    } else {
      return parkinglotList
          ?.where((parkingLot) =>
              parkingLot.parkingName
                  .toLowerCase()
                  .contains(widget.searchQuery!.toLowerCase()) ||
              parkingLot.locationName
                  .toLowerCase()
                  .contains(widget.searchQuery!.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ParkingModel>? filteredParkingLots = getFilteredParkingLots();

    return filteredParkingLots == null
        ? const Loader(
            appbartext: 'Parking Lots Near You',
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Parking Lots near you!',
                  style: TextStyle(color: greenColor, fontSize: 18)),
              iconTheme: IconThemeData(color: greenColor),
              backgroundColor: darkbgColor,
              elevation: 0,
              actions: const [Icon(Icons.search)],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const BikeChoiceChipWidget(),
                        sizedwten(context),
                        const CarChoiceChipWidget(),
                        sizedwten(context),
                        const TruckChoiceChipWidget()
                      ],
                    ),
                    sizedten(context),
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (filteredParkingLots![index].approved == true) {
                          return ParkingLotContainer(
                              parkinglotList: filteredParkingLots, index: index);
                        } else {
                          return const Text('Admin Approval Pending');
                        }
                      },
                      itemCount: filteredParkingLots!.length,
                      separatorBuilder: (context, index) {
                        return sizedten(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
