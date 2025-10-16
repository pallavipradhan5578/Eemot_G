import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'home_screen.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({super.key});

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor,title: Text(
        "Complain",
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
      ),
      body: Center(child: Text("Complain Screen")),
    );
  }
}
