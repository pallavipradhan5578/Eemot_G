import 'package:flutter/material.dart';
import 'package:gps/core/constants/app_colors.dart';
import 'package:gps/views/screens/settings/privacy_policy.dart';
import 'package:gps/views/screens/home/profile_screen.dart';
import 'package:gps/views/screens/settings/recharge_screen.dart';
import 'package:gps/views/screens/settings/terms_and_condition.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home_screen.dart';
import 'about_us_screen.dart';
import '../auth/login_screen.dart';
import 'contact_us_screen.dart';
import 'kyc_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  final List<Map<String, dynamic>> menuItems = const [
    {'icon': Icons.person, 'title': 'Profile'},
     {'icon': Icons.verified_user, 'title': 'Kyc'},
    {'icon': Icons.account_balance_wallet, 'title': 'Recharge'},
    {'icon': Icons.info_outline, 'title': 'About Us'},
    {'icon': Icons.phone, 'title': 'Contact Us'},
    {'icon': Icons.privacy_tip_outlined, 'title': 'Privacy Policy'},
    {'icon': Icons.description_outlined, 'title': 'Terms And Condition'},
    {'icon': Icons.share, 'title': 'Share App'},
    {'icon': Icons.logout, 'title': 'Logout'},
  ];

  void handleMenuTap(BuildContext context, String title) {
    switch (title) {
      case 'Profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
        break;
       case 'Kyc':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const KycScreen()),
        );
        break;

      case 'Recharge':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RechargeScreen()),
        );
        break;
      case 'About Us':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AboutUsScreen()),
        );
        break;
      case 'Contact Us':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ContactUsScreen()),
        );
        break;

      case 'Privacy Policy':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
        );
        break;
      case 'Terms And Condition':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TermsScreen()),
        );
        break;
      case 'Share App':
        Share.share(
          '🚗 Download Eemot Smart GPS App:\n\n'
              'Track your vehicle, manage devices, and more with the Eemot Smart GPS App.\n\n'
              '📥 Download Now: https://eemotrack.com/frontend/assets/app/eemot-smart.apk',
          subject: 'Eemot Smart GPS App',
        );
        break;


      case 'Logout':
        () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
                (Route<dynamic> route) => false,
          );
        }();
        break;
      default:
        print('Tapped $title');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon:
          const Icon(Icons.arrow_back_ios_new_rounded, color:AppColors.secondaryColor),
          onPressed: ()  {Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Image.asset(
                'assets/images/eemot_logo.png',
                width: 200,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 50),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: menuItems.length,
              separatorBuilder: (context, index) =>
              const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return GestureDetector(
                  onTap: () => handleMenuTap(context, item['title']),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(item['icon'], size: 30, color:AppColors.blackColor),
                        const SizedBox(width: 15),
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                    color: AppColors.primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
