import 'package:flutter/material.dart';
import 'package:gps/views/screens/settings/privacy_policy.dart';
import 'package:gps/views/screens/home/profile_screen.dart';
import 'package:gps/views/screens/settings/recharge_screen.dart';
import 'package:gps/views/screens/settings/terms_and_condition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about_us_screen.dart';
import '../auth/login_screen.dart';
import 'contact_us_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  final List<Map<String, dynamic>> menuItems = const [
    {'icon': Icons.person, 'title': 'Profile'},
    {'icon': Icons.account_balance_wallet, 'title': 'Recharge'},
    {'icon': Icons.info_outline, 'title': 'About Us'},
    {'icon': Icons.phone, 'title': 'Contact Us'},
    {'icon': Icons.privacy_tip_outlined, 'title': 'Privacy Policy'},
    {'icon': Icons.description_outlined, 'title': 'Terms And Condition'},
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFF6B35),
        leading: IconButton(
          icon:
          const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                      color: const Color(0xFFFF6B35).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(item['icon'], size: 30, color: Colors.black),
                        const SizedBox(width: 15),
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
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
                    color: Color(0xFFFF6B35), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
