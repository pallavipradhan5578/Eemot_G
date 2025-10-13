import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:gps/views/screens/auth/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  final Random _random = Random();


  double _dot1Size = 15;
  double _dot2Size = 15;
  double _dot3Size = 15;

  @override
  void initState() {
    super.initState();

    // Randomly change dots size every 300ms
    _timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      setState(() {
        _dot1Size = 12 + _random.nextDouble() * 12; // 12 to 24
        _dot2Size = 12 + _random.nextDouble() * 12;
        _dot3Size = 12 + _random.nextDouble() * 12;
      });
    });

    // Navigate to Login after 3 seconds
    Timer(const Duration(seconds: 5), () {
      _timer.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Image.asset(
                  'assets/images/eemot_logo.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 40),

                // Tagline
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Eemot GPS is Not Just A Technology,\nIts Lifestyle',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 60),

                // Loading Three Dots (animated size)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedDot(size: _dot1Size),
                    const SizedBox(width: 5),
                    AnimatedDot(size: _dot2Size),
                    const SizedBox(width: 5),
                    AnimatedDot(size: _dot3Size),
                  ],
                ),
              ],
            ),
          ),

          // Bottom "Powered By" text
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  'Powered By',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                Text(
                  'Eemotrack India',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Animated Dot widget with smooth transition (fixed size container)
class AnimatedDot extends StatelessWidget {
  final double size;
  const AnimatedDot({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18, // Fixed outer size
      height: 18,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}