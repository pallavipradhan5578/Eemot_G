import 'package:flutter/material.dart';
import 'package:gps/view_models/auth_viewmodels.dart';
import 'package:gps/view_models/location_viewmodels.dart';
import 'package:gps/views/screens/auth/home_screen.dart';
import 'package:gps/views/screens/auth/spalsh_screen.dart';
import 'package:provider/provider.dart';

import 'package:gps/views/screens/auth/register_screen.dart';
import 'package:gps/views/screens/auth/login_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
      ],
      child: MaterialApp(
        title: 'Eemot GPS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/register': (context) => const RegisterScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}