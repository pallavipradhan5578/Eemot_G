import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'add_vehicle_screen.dart';
import 'home_screen.dart';

class MyVehicleScreen extends StatefulWidget {
  const MyVehicleScreen({super.key});

  @override
  State<MyVehicleScreen> createState() => _MyVehicleScreenState();
}

class _MyVehicleScreenState extends State<MyVehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.secondaryColor,
          ),
        ),
        title: Text(
          "My vehicle",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60, // height bada karo
        width: 160, // width bada karo
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.primaryColor, // button color
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddVehicleScreen()),
            );
          },
          label: const Text(
            "Add Vehicle",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          icon: const Icon(Icons.add,size: 50, color: AppColors.secondaryColor),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // same bottom-right
    );
  }
}
