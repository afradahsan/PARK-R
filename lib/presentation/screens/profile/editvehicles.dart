import 'package:flutter/material.dart';
import 'package:parkr/data/models/vehiclemodel.dart';
import 'package:parkr/data/repositories/myvehicles/myvehicle_repo.dart';
import 'package:parkr/presentation/screens/auth/widgets/elevatedbutton.dart';
import 'package:parkr/presentation/screens/auth/widgets/textformfeild.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

class EditVehicle extends StatefulWidget {
  const EditVehicle({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {

  var vehicletypes = ['Two Wheeler', 'Three Wheeler', 'Four Wheeler'];

  String dropdownvalue = '';

  TextEditingController vehicleNameC = TextEditingController();
  TextEditingController vehicleNumberC = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    vehicleNameC = TextEditingController(text: widget.vehicle.vehicleName);
    vehicleNumberC = TextEditingController(text: widget.vehicle.vehicleNumber);
    dropdownvalue = widget.vehicle.vehicleType;
  }

  void editvehicle() {
    setState(() {
      isLoading = true; 
    });
    MyVehicleRepo().editVehicle(context: context, vehicleName: vehicleNameC.text, vehicleNumber: vehicleNumberC.text, vehicleType: dropdownvalue, vehicleId: widget.vehicle.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        title: const Text(
          'Edit Vehicle',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose Vehicle Type'),
            sizedten(context),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    dropdownColor: darkbgColor,
                    value:
                        dropdownvalue == '' ? vehicletypes[0] : dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: vehicletypes.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                )),
            sizedten(context),
            TFormFeild(
                controller: vehicleNameC,
                hintText: 'Vehicle Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter name';
                  } else {
                    return null;
                  }
                },
                icon: Icons.local_taxi),
            sizedten(context),
            TFormFeild(
                controller: vehicleNumberC,
                hintText: 'Vehicle Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter number';
                  } else {
                    return null;
                  }
                },
                icon: Icons.confirmation_number_sharp),
            sizedten(context),
            isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator()) // Show loader if isLoading is true
                : AuthButton(
                    onPressed: () {
                      editvehicle();
                    },
                    ButtonText: 'Update')
          ],
        ),
      )),
    );
  }
}