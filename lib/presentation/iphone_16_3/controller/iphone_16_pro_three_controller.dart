import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_management/core/utils/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/app_export.dart';
import '../models/iphone_16_pro_three_model.dart';

class Iphone16ProThreeController extends GetxController {
  TextEditingController nametwoController = TextEditingController();
  TextEditingController emailtwoController = TextEditingController();
  TextEditingController passwordtwoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Rx<Iphone16ProThreeModel> iphone16ProThreeModelObj = Iphone16ProThreeModel().obs;
  Rx<String> userTypeSelection = "".obs;

  Rx<String> selectedBlock = "".obs;
  List<String> blocks = ['West', 'Bommanahalli', 'Mahadevapura', 'South', 'RR Nagar'];

  Future<void> signUpUser() async {
    final name = nametwoController.text.trim();
    final email = emailtwoController.text.trim();
    final password = passwordtwoController.text.trim();
    final block = selectedBlock.value;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Input Error", "Please enter email and password");
      return;
    }
    if (userTypeSelection.value.isEmpty) {
      Get.snackbar("Input Error", "Please select a user type.");
      return;
    }
    if (userTypeSelection.value == "Customer" && block.isEmpty) {
      Get.snackbar("Input Error", "Please select your block.");
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user?.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'userType': userTypeSelection.value,
        'block': block,
        'address':addressController.text
      });

      // Add to block collection if user is customer
      if (userTypeSelection.value == "Customer") {
        await FirebaseFirestore.instance.collection(block).doc(uid).set({
          'name': name,
          'email': email,
          'userType': userTypeSelection.value,
          'address':addressController.text
        });
      }

      await SharedPrefsHelper.saveUserDetails(
        name: name,
        email: email,
        userType: userTypeSelection.value,
      );

      Get.snackbar("Success", "Signed up: ${userCredential.user?.email}");
      Get.offAllNamed(AppRoutes.iphone16ProTwoScreen);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'The account already exists for that email.';
          break;
        default:
          message = e.message ?? 'Unknown error';
      }
      Get.snackbar("Signup Failed", message);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  @override
  void onClose() {
    super.onClose();
    nametwoController.dispose();
    emailtwoController.dispose();
    passwordtwoController.dispose();
  }
}
