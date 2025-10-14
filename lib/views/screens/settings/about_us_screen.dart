import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'About Us',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color(0xFFFF6B35),
    ),
    body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.aboutText1,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              AppString.aboutText2,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              AppString.aboutText3,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),SizedBox(height: 10,),
            Text(
              AppString.aboutText4,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:Color(0xFFFF6B35)),
            ),
            Text(
              AppString.aboutText5,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500 ),
            ),
            Text(
              AppString.aboutText6,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:Color(0xFFFF6B35)),
            ),
            Text(
              AppString.aboutText7,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    ),
  );
}
