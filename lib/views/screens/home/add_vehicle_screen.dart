import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/storage_service.dart';
import '../../../data/models/add_vehicle.dart';
import '../../../view_models/vehicle_type_viewmodels.dart';
import '../../../view_models/add_vehicle_viewmodel.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleTypeController = TextEditingController();
  final _vehicleNumController = TextEditingController();
  final _vehicleModelController = TextEditingController();
  final _vehicleColorController = TextEditingController();
  final _chassisNumController = TextEditingController();
  final _engineNumController = TextEditingController();
  final _insuranceExpDateController = TextEditingController();
  final _ownersNameController = TextEditingController();

  // Image variables
  File? image1; // Product Image
  File? image2; // Vehicle Photo
  File? image3; // Insurance
  File? image4; // PUC
  File? image5; // Registration (RC)
  File? image6; // Id Proof

  String? _selectedVehicleType;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<VehicleTypeViewModel>(
        context,
        listen: false,
      ).fetchVehicleTypes();
    });
  }

  @override
  void dispose() {
    _vehicleTypeController.dispose();
    _vehicleNumController.dispose();
    _vehicleModelController.dispose();
    _vehicleColorController.dispose();
    _chassisNumController.dispose();
    _engineNumController.dispose();
    _insuranceExpDateController.dispose();
    _ownersNameController.dispose();
    super.dispose();
  }

  void _showVehicleTypeSelector(BuildContext context) {
    _selectedVehicleType = _vehicleTypeController.text.isNotEmpty
        ? _vehicleTypeController.text
        : null;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Consumer<VehicleTypeViewModel>(
            builder: (context, vm, _) {
              if (vm.isLoading) return const Center(child: CircularProgressIndicator());
              final types = vm.vehicleTypes;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Select Vehicle Type",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: types.length,
                      itemBuilder: (context, index) {
                        final type = types[index];
                        return RadioListTile<String>(
                          value: type.vehicleType,
                          groupValue: _selectedVehicleType,
                          onChanged: (value) {
                            setState(() {
                              _selectedVehicleType = value;
                              _vehicleTypeController.text = value!;
                            });
                            Navigator.pop(context);
                          },
                          title: Text(
                            type.vehicleType,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _pickImage(int index) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        switch (index) {
          case 1:
            image1 = File(pickedFile.path);
            break;
          case 2:
            image2 = File(pickedFile.path);
            break;
          case 3:
            image3 = File(pickedFile.path);
            break;
          case 4:
            image4 = File(pickedFile.path);
            break;
          case 5:
            image5 = File(pickedFile.path);
            break;
          case 6:
            image6 = File(pickedFile.path);
            break;
        }
      });
    }
  }

  bool _validateForm() {
    if (_vehicleTypeController.text.isEmpty) return _showError('Please select vehicle type');
    if (_ownersNameController.text.isEmpty) return _showError('Please enter owner\'s name');
    if (_vehicleNumController.text.isEmpty) return _showError('Please enter vehicle number');
    if (_vehicleModelController.text.isEmpty) return _showError('Please enter vehicle model');
    if (_vehicleColorController.text.isEmpty) return _showError('Please enter vehicle color');
    if (_chassisNumController.text.isEmpty) return _showError('Please enter chassis number');
    if (_engineNumController.text.isEmpty) return _showError('Please enter engine number');
    if (_insuranceExpDateController.text.isEmpty) return _showError('Please select insurance expiry date');
    return true;
  }

  bool _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
    return false;
  }

  void _submitForm() async {
    final userData = await StorageService.getUserData();
    if (userData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }

    if (!_validateForm()) return;

    // Create the request with all required fields
    final request = AddVehicleRequest(
      vehicleType: _vehicleTypeController.text,
      ownersName: _ownersNameController.text,
      vehicleNumber: _vehicleNumController.text,
      vehicleModel: _vehicleModelController.text,
      vehicleColor: _vehicleColorController.text,
      chassisNumber: _chassisNumController.text,
      engineNumber: _engineNumController.text,
      insuranceExpiryDate: _insuranceExpDateController.text,
      userId: userData['userId']?.toString() ?? '',
      createdById: userData['userId']?.toString() ?? '',
    );

    // Call the ViewModel API
    final viewModel = Provider.of<AddVehicleViewModel>(context, listen: false);
    final success = await viewModel.addVehicle(
      request: request,
      vehiclePhoto: image2,
      idProof: image6,
      insuranceDoc: image3,
      pollutionDoc: image4,
      rcDoc: image5,
      productImage: image1,
      authToken: userData['token'],
    );

    if (success) {
      _showSuccessDialog(viewModel.response?.message ?? "Vehicle added successfully");
    } else {
      _showErrorDialog(viewModel.errorMessage ?? "Failed to add vehicle");
    }
  }
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error', style: TextStyle(color: Colors.red)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success', style: TextStyle(color: Colors.green)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddVehicleScreen()));// Close dialog
             // Go back to previous page
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }



  Widget _buildImageUpload(String label, File? file, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _pickImage(index),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.blackColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: file != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(file, fit: BoxFit.cover),
            )
                : const Icon(Icons.image, size: 80, color: AppColors.primaryColor),
          ),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.secondaryColor),
        ),
        title: const Text(
          'Add Vehicle',
          style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<AddVehicleViewModel>(
        builder: (context, vm, _) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => _showVehicleTypeSelector(context),
                          child: AbsorbPointer(
                            child: CustomTextField(
                              hint: 'Select Vehicle Type',
                              controller: _vehicleTypeController,
                            ),
                          ),
                        ),
                        CustomTextField(hint: 'Owner\'s Name', controller: _ownersNameController),
                        CustomTextField(hint: 'Vehicle Number', controller: _vehicleNumController),
                        CustomTextField(hint: 'Vehicle Model', controller: _vehicleModelController),
                        CustomTextField(hint: 'Vehicle Color', controller: _vehicleColorController),
                        CustomTextField(hint: 'Chassis Number', controller: _chassisNumController),
                        CustomTextField(hint: 'Engine Number', controller: _engineNumController),
                        GestureDetector(
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              _insuranceExpDateController.text =
                              "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                            }
                          },
                          child: AbsorbPointer(
                            child: CustomTextField(
                              hint: 'Insurance Expiry Date (DD-MM-YYYY)',
                              controller: _insuranceExpDateController,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Upload Images",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildImageUpload("Product Image", image1, 1),
                              const SizedBox(width: 10),
                              _buildImageUpload("Vehicle Image", image2, 2),
                              const SizedBox(width: 10),
                              _buildImageUpload("Insurance", image3, 3),
                              const SizedBox(width: 10),
                              _buildImageUpload("PUC", image4, 4),
                              const SizedBox(width: 10),
                              _buildImageUpload("Registration", image5, 5),
                              const SizedBox(width: 10),
                              _buildImageUpload("Id Proof", image6, 6),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomButton(text: 'Submit', onPressed: _submitForm),
                      ],
                    ),
                  ),
                ),
              ),
              if (vm.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
