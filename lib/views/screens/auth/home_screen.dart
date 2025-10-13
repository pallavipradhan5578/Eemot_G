import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gps/views/screens/compain_screen.dart';
import 'package:gps/views/screens/my_vehicle_screen.dart';
import 'package:gps/views/screens/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../view_models/weather_viewmodel.dart';
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
  int activeIndex = 0;
  final List<String> bannerImages = [
    'assets/images/bannerImg1.png',
    'assets/images/bannerImg2.png',
    'assets/images/bannerImg3.png',
    'assets/images/bannerImg4.png',
    'assets/images/bannerImg5.png',
    'assets/images/bannerImg6.png',
    'assets/images/bannerImg7.png',
    'assets/images/bannerImg8.png',
    'assets/images/bannerImg9.png',
    'assets/images/bannerImg10.png',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().loadUserData();
      context.read<WeatherViewModel>().fetchWeather();
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyVehicleScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ComplainScreen(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingScreen(),
          ),
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
            padding: const EdgeInsets.all(18),
            child: Consumer<UserViewModel>(
              builder: (context, userViewModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔝 Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                          icon: const Icon(
                            Icons.notifications_outlined,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 👋 Greeting
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

                    /// 📍 Location & 🌤 Weather
                    Consumer<WeatherViewModel>(
                      builder: (context, weatherVM, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Location Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  (weatherVM.area.isNotEmpty &&
                                      weatherVM.city.isNotEmpty)
                                      ? '${weatherVM.area}, ${weatherVM.city}'
                                      : '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Weather Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.wb_sunny,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  (weatherVM.temperature.isNotEmpty &&
                                      weatherVM.condition.isNotEmpty)
                                      ? '${weatherVM.temperature} - ${weatherVM.condition}'
                                      : '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 25),

                    // 🟧 Banner
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                      ),
                      items: bannerImages.map((imagePath) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // Dots Indicator
                    Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: bannerImages.length,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Color(0xFFFF6B35),
                          dotColor: Colors.grey,
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🧩 Menu Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
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
        currentIndex: _selectedIndex,backgroundColor: Colors.white,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF6B35),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_filled,size: 30,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined,size: 30,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined,size: 30,),
            label: '',
          ),
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
          color: Color(0xFFFF6B35).withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 25, color: Color(0xFFFF6B35)),

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
