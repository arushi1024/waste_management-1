import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/app_export.dart';
import '../models/iphone_16_pro_three_model.dart';

class Iphone16ProThreeController extends GetxController {
  TextEditingController nametwoController = TextEditingController();
  TextEditingController emailtwoController = TextEditingController();
  TextEditingController passwordtwoController = TextEditingController();

  Rx<Iphone16ProThreeModel> iphone16ProThreeModelObj =
      Iphone16ProThreeModel().obs;

  Rx<String> userTypeSelection = "".obs;

  Future<void> signUpUser() async {
    final email = emailtwoController.text.trim();
    final password = passwordtwoController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Input Error", "Please enter email and password");
      return;
    }
    if (userTypeSelection.value.isEmpty) {
    Get.snackbar("Input Error", "Please select a user type.");
    return;
}

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Signed up: ${userCredential.user?.email}");
      Get.offAllNamed(AppRoutes.iphone16ProTwoScreen);
      // Optionally navigate to another screen:
      // Get.toNamed(AppRoutes.homeScreen);
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
