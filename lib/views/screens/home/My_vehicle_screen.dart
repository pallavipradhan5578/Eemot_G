import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/vehicle_details_model.dart';
import '../../../view_models/my_vehicle_viewmodel.dart';
import '../../../view_models/vehicle_model.dart';
import 'add_vehicle_screen.dart';
import 'home_screen.dart';

class MyVehicleScreen extends StatefulWidget {
  const MyVehicleScreen({super.key});

  @override
  State<MyVehicleScreen> createState() => _MyVehicleScreenState();
}

class _MyVehicleScreenState extends State<MyVehicleScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _blinkController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // Fetch vehicles on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("🚀 Fetching vehicles...");
      Provider.of<MyVehicleViewModel>(context, listen: false).fetchVehicles();
    });
  }


  @override
  void dispose() {
    _tabController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.secondaryColor,
          ),
        ),
        title: const Text(
          "My Vehicle",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Active"),
            Tab(text: "Inactive"),
          ],
        ),
      ),
      body: Consumer<MyVehicleViewModel>(
        builder: (context, viewModel, child) {
          print("📊 Loading: ${viewModel.isLoading}");
          print("📦 All Vehicles: ${viewModel.allVehicles.length}");
          print("✅ Active Vehicles: ${viewModel.activeVehicles.length}");
          print("❌ Inactive Vehicles: ${viewModel.inactiveVehicles.length}");
          print("⚠️ Error: ${viewModel.errorMessage}");

          if (viewModel.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 16),
                  Text("Loading vehicles..."),
                ],
              ),
            );
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Error loading vehicles',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      viewModel.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => viewModel.fetchVehicles(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildVehicleList(viewModel.activeVehicles, viewModel, "Active"),
              _buildVehicleList(viewModel.inactiveVehicles, viewModel, "Inactive"),
            ],
          );
        },
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 160,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.primaryColor,
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddVehicleScreen()),
            );

            if (result == true) {
              Provider.of<MyVehicleViewModel>(context, listen: false)
                  .fetchVehicles();
            }
          },
          label: const Text(
            "Add Vehicle",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          icon: const Icon(
            Icons.add,
            size: 30,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleList(
      List<VehicleDetailsModel> vehicles, MyVehicleViewModel viewModel, String type) {
    print("🔍 Building $type list with ${vehicles.length} vehicles");

    if (vehicles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car_outlined,
                size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'No $type vehicles found',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Pull down to refresh',
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: viewModel.refreshVehicles,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];
          print("🚗 Vehicle $index: ${vehicle.vehicleNumber} - Status: ${vehicle.status}");
          return _buildVehicleCard(vehicle);
        },
      ),
    );
  }
  Widget _buildVehicleCard(VehicleDetailsModel vehicle) {
    final viewModel = Provider.of<MyVehicleViewModel>(context, listen: false);
    final statusText = viewModel.getStatusText(vehicle.status);
    final statusColor = viewModel.getStatusColor(vehicle.status);

    final isProcessing = vehicle.status == 'processing' ||
        vehicle.status == 'Processing' ||
        vehicle.status == 2;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Vehicle number and status row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    vehicle.vehicleNumber ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                isProcessing
                    ? FadeTransition(
                  opacity: _blinkController,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          statusText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                )
                    : Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusText,
                    style:
                    const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 🔹 Vehicle information rows
            _buildInfoRow(Icons.info_outline, "Product Model",
                vehicle.productModel ?? "N/A"),
            _buildInfoRow(Icons.date_range, "Activation Date",
                vehicle.activationDate ?? "N/A"),
            _buildInfoRow(Icons.shield, "Warranty",
                vehicle.warranty ?? "N/A"),
            _buildInfoRow(Icons.subscriptions, "Subscription",
                vehicle.subscription ?? "N/A"),
            _buildInfoRow(Icons.settings, "AMC", vehicle.amc ?? "N/A"),
            _buildInfoRow(Icons.verified_user, "KYC Status",
                vehicle.kycStatus ?? "N/A"),

            if (vehicle.appUrl != null && vehicle.appUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        final Uri url = Uri.parse(vehicle.appUrl!);


                        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                          // If launch fails, show error
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Could not open the link"),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Error opening link: $e"),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.open_in_new),
                    label: const Text("Open App"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }


  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
