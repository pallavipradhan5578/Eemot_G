import 'package:flutter/material.dart';
import 'package:gps/core/constants/app_colors.dart';

import '../../../core/constants/app_strings.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Privacy Policy',
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
              AppString.privacyText1,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              AppString.privacyText2,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              AppString.privacyText3,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              AppString.privacyText,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              AppString.privacyText4,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,),
            ),
            Text(
              AppString.privacyText5,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,

              ),
            ),
            Text(
              AppString.privacyText6,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,),
            ),
      Text(
        AppString.privacyText7,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,

        ),
      ), Text(
              AppString.privacyText8,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
            ),
        Text(
          AppString.privacyText9,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,

          ),),
            Text(
              AppString.privacyText10,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
            ),
            Text(
              AppString.privacyText11,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,

              ),),
            Text(
              AppString.privacyText12,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
            ),
            Text(
              AppString.privacyText13,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,

              ),),
            Text(
              AppString.privacyText14,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
            ),
            Text(
              AppString.privacyText15,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,

              ),),
            Text(
              AppString.privacyText16,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
            ),
            Text(
              AppString.privacyText17,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,

              ),),
            Text(
              AppString.privacyText18,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
            ),
            Text(
              AppString.privacyText19,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,

              ),),
            Text(
              AppString.contactUs,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
            ),
            Text(
              AppString.privacyText21,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,

              ),),Text(
              AppString.aboutText4,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              AppString.aboutText5,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),SizedBox(height: 10,),
            Text(
              AppString.aboutText6,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              AppString.aboutText7,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF6B35),
              ),
            ),



          ],
        ),
      ),
    ),
  );
}
