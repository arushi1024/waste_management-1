import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../core/app_export.dart';
import 'controller/iphone_16_pro_seven_controller.dart';

class Iphone16ProSevenScreen extends GetWidget<Iphone16ProSevenController> {
  Iphone16ProSevenScreen({super.key});

  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController locationController = TextEditingController();  // New location field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "File a Complaint",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            _buildVehicleNumberInput(),
            const SizedBox(height: 25),
            _buildComplaintReasonInput(),
            const SizedBox(height: 25),
            _buildLocationInput(),  // New location input
            const SizedBox(height: 40),
            CustomElevatedButton(
              text: "Submit",
              onPressed: () async {
                final vehicleNumber = vehicleNumberController.text.trim();
                final reason = reasonController.text.trim();
                final location = locationController.text.trim();  // Get the location input

                if (vehicleNumber.isEmpty || reason.isEmpty || location.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("Please fill in all fields."),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                await saveComplaint(vehicleNumber, reason, location);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Complaint submitted successfully!"),
                    backgroundColor: Colors.green,
                  ),
                );

                Get.toNamed(AppRoutes.iphone16ProEightScreen);
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Complaint",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.toNamed(AppRoutes.homepageWithMenuScreen),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
    );
  }

  Widget _buildVehicleNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Vehicle Number",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          hintText: "Enter vehicle number",
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          controller: vehicleNumberController,
        ),
      ],
    );
  }

  Widget _buildComplaintReasonInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Reason for Complaint",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          hintText: "Describe your issue...",
          maxLines: 6,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          controller: reasonController,
        ),
      ],
    );
  }

  Widget _buildLocationInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Location",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          hintText: "Enter your location",
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          controller: locationController,
        ),
      ],
    );
  }
}

Future<void> saveComplaint(String vehicleNumber, String reason, String location) async {
  try {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      print("User not logged in.");
      return;
    }

    await FirebaseFirestore.instance.collection('complaints').add({
      'vehicleNumber': vehicleNumber,
      'reason': reason,
      'location': location,  // Save the location field
      'status': 'open',      // Set status to 'open'
      'timestamp': FieldValue.serverTimestamp(),
      'userId': uid,
    });

    print("Complaint submitted successfully.");
  } catch (e) {
    print("Error submitting complaint: $e");
  }
}
