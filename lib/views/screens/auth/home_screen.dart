import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../map_screen.dart';
import '../profile_screen.dart';
import '../../../view_models/auth_viewmodels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().loadUserData();
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
      // Already on home
        break;
      case 1:
      // TODO: Navigate to Delivery/Vehicles screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Delivery screen coming soon')),
        );
        break;
      case 2:
      // TODO: Navigate to Orders screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Orders screen coming soon')),
        );
        break;
      case 3:
      // TODO: Navigate to Settings screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings screen coming soon')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Consumer<UserViewModel>(
              builder: (context, userViewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Profile Image - Tappable
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFFF6B35),
                                width: 1.5,
                              ),
                            ),
                            child: ClipOval(
                              child: Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_outlined, size: 30),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Greeting
                    const Text(
                      'Good Morning!',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF6B35),
                      ),
                    ),
                    Text(
                      userViewModel.name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Location & Weather
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.red, size: 20),
                        SizedBox(width: 5),
                        Text(
                          'Keshri Nagar, Patna',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(Icons.wb_sunny, color: Colors.orange, size: 20),
                        SizedBox(width: 5),
                        Text(
                          '22.2°C - Clear',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Banner
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFFF6B35).withOpacity(0.2),
                      ),
                      child: const Center(
                        child: Text(
                          'Eemotrack Banner',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6B35),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Menu Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 15,
                      children: [
                        _buildMenuItem(
                          icon: Icons.directions_car,
                          label: 'Vehicle',
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          icon: Icons.phonelink,
                          label: 'Recharge',
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          icon: Icons.route,
                          label: 'Track',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MapScreen(),
                              ),
                            );
                          },
                        ),
                        _buildMenuItem(
                          icon: Icons.shopping_cart,
                          label: 'Buy',
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          icon: Icons.play_circle_outline,
                          label: 'Demo',
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          icon: Icons.help_outline,
                          label: 'Support',
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          icon: Icons.report_problem_outlined,
                          label: 'Complain',
                          onTap: () {},
                        ),
                        _buildMenuItem(
                          icon: Icons.more_horiz,
                          label: 'Other',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF6B35),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.description_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: ''),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: Colors.black),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}