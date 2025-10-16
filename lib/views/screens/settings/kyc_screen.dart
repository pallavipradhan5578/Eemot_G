import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../home/home_screen.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor,title: Text(
        "KYC",
        style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.bold),
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
      ),
      body: Center(child: Text("KYC Screen")),
    );
  }
}
