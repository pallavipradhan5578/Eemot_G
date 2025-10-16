import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gps/views/widgets/custom_button.dart';
import 'package:gps/views/widgets/custom_textfield.dart';
import 'package:gps/core/utils/validators.dart';
import '../../../core/constants/app_colors.dart';
import '../../../view_models/auth_viewmodels.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final authViewModel = context.read<AuthViewModel>();

      final success = await authViewModel.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (success && mounted) {

        Navigator.pushReplacementNamed(context, '/home');
      } else if (mounted && authViewModel.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authViewModel.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,appBar: AppBar(leading:  IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      style: IconButton.styleFrom(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),backgroundColor: Colors.white,),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              
              
              
              
                  // Title
                  const Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Glad to see you, Again',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 50),
              
                  // Email Field
                  CustomTextField(
                   // label: 'Email',
                    hint: 'Enter Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 20),
              
                  // Password Field
                  CustomTextField(
                  //  label: 'Password',
                    hint: 'Enter password',
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    validator: Validators.validatePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
              
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: Navigate to forgot password
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Forgot Password feature coming soon')),
                        );
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFE74C3C),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
              
                  // Login Button
                  Consumer<AuthViewModel>(
                    builder: (context, authViewModel, child) {
                      return CustomButton(
                        text: 'Login',
                        onPressed: _handleLogin,
                        isLoading: authViewModel.isLoading,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
              
                  // Register Link
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFE74C3C),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
              
                  // Support Button
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.headset_mic,
                            color: AppColors.secondaryColor,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Support',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
