import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


import '../../view_models/location_viewmodels.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    print('🗺️ MapScreen initState called');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('🔄 Fetching current location...');
      context.read<LocationViewModel>().fetchCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B35),
        title: const Text('Track Location', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<LocationViewModel>(
        builder: (context, locationViewModel, child) {
          print('📍 Location: ${locationViewModel.latitude}, ${locationViewModel.longitude}');
          print('🏠 Address: ${locationViewModel.address}');
          print('⏳ Loading: ${locationViewModel.isLoading}');

          if (locationViewModel.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFFFF6B35)),
                  SizedBox(height: 20),
                  Text('Fetching your location...'),
                ],
              ),
            );
          }

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    locationViewModel.latitude,
                    locationViewModel.longitude,
                  ),
                  zoom: 15,
                ),
                onMapCreated: (controller) {
                  print('✅ Google Map Created!');
                  _mapController = controller;
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('current_location'),
                    position: LatLng(
                      locationViewModel.latitude,
                      locationViewModel.longitude,
                    ),
                    infoWindow: InfoWindow(
                      title: 'Your Location',
                      snippet: locationViewModel.address,
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange,
                    ),
                  ),
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: false, // Custom button use kar rahe hain
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                compassEnabled: true,
              ),

              // Address Card
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFFFF6B35),
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          locationViewModel.address,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('🔄 Refresh location button pressed');
          context.read<LocationViewModel>().fetchCurrentLocation();
        },
        backgroundColor: const Color(0xFFFF6B35),
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}