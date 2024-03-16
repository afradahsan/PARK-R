import 'package:flutter/material.dart';
import 'package:parkr/presentation/screens/admin/widgets/pickimagecontainer.dart';
import 'package:parkr/presentation/screens/admin/widgets/tformadmin.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

class AddParking extends StatelessWidget {
  AddParking({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationNameCntrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: greenColor),
        title: Text(
          'Add New Parking Lot',
          style: TextStyle(color: greenColor, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const PickImageContainer(),
            sizedten(context),
            TFormAdmin(
              controller: titleController,
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
            TFormAdmin
            (
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
          ],
        ),
      )),
    );
  }
}
