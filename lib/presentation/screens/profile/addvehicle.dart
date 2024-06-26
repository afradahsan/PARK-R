import 'package:flutter/material.dart';
import 'package:parkr/data/repositories/myvehicles/myvehicle_repo.dart';
import 'package:parkr/presentation/screens/auth/widgets/elevatedbutton.dart';
import 'package:parkr/presentation/screens/auth/widgets/textformfeild.dart';
import 'package:parkr/utils/colors.dart';
import 'package:parkr/utils/constants.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  var vehicletypes = ['Two Wheeler', 'Three Wheeler', 'Four Wheeler'];
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  String dropdownvalue = '';
  final TextEditingController vehicleNameC = TextEditingController();
  final TextEditingController vehicleNumberC = TextEditingController();
  bool isLoading = false; // Track loading state

  void saveVehicle(BuildContext mainContext) {
    setState(() {
      isLoading = true;
    });
    MyVehicleRepo().addVehicles(
      context: mainContext,
      vehicleName: vehicleNameC.text,
      vehicleNumber: vehicleNumberC.text,
      vehicleType: dropdownvalue,
      scaffoldMessengerKey: scaffoldMessengerKey, // Pass the GlobalKey here
      onSuccess: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext mainContext) {
    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: greenColor),
        title: const Text(
          'Add Vehicle',
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
                    width: 0.80,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    dropdownColor: darkbgColor,
                    value: dropdownvalue == '' ? vehicletypes[0] : dropdownvalue,
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
                ),
              ),
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
                icon: Icons.local_taxi,
              ),
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
                icon: Icons.confirmation_number_sharp,
              ),
              sizedten(context),
              AuthButton(
                loading: isLoading,
                onPressed: () {
                  saveVehicle(mainContext);
                },
                ButtonText: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
