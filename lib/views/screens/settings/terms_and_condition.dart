import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Terms and condition',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFFF6B35),
      ),body: Padding(
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
                AppString.termText1,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Text(
                AppString.termText2,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: AppColors.primaryColor,),
              ),
              SizedBox(height: 10),
              Text(
                AppString.termText3,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,

                ),
              ),
              SizedBox(height: 10),
              Text(
                AppString.termText4,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: AppColors.primaryColor,),
              ),
              SizedBox(height: 10),
              Text(
                AppString.termText5,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,

                ),
              ),
              SizedBox(height: 10),
              Text(
                AppString.termText6,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: AppColors.primaryColor,),
              ),
              SizedBox(height: 10),
              Text(
                AppString.termText7,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,

                ),
              ),SizedBox(height: 10),
              Text(
                AppString.termText8,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: AppColors.primaryColor,),
              ),
              SizedBox(height: 10),
              Text(
                AppString.termText9,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,

                ),
              ),SizedBox(height: 10),
            Text(
              AppString.termText10,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: AppColors.primaryColor,),
            ),
            SizedBox(height: 10),
            Text(
              AppString.termText11,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,

              ),
            ),
            SizedBox(height: 10),
        Text(
          AppString.termText12,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: AppColors.primaryColor,),
        ),
        SizedBox(height: 10),
        Text(
          AppString.termText13,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,

          ),
        ),SizedBox(height: 10), Text(
                " 9. Contact Us",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.primaryColor),
              ),SizedBox(height: 10),
              Text(
                AppString.privacyText21,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
             Text(
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
      ),);
}