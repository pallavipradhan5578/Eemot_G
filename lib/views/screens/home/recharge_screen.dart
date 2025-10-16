import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'home_screen.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  appBar: AppBar(backgroundColor: AppColors.primaryColor,title: Text(
      "Recharge",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
      leading: IconButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        icon: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.secondaryColor,),
      ),
    ),body: Center(child: Text("Recharge screen"),),);
  }
}
