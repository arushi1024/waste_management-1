import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:waste_management/core/utils/shared_preferences_helper.dart';
import 'package:waste_management/presentation/frame_seventeen_screen/controller/frame_seventeen_controller.dart';
import '../../../core/app_export.dart';

class Iphone16ProTwoController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Login Error", "Please enter both email and password");
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userDetails = await SharedPrefsHelper.getUserDetails();


      if (userDetails['email'] == email) {
        final profileController = Get.put(FrameSeventeenController());
        profileController.userName.value = userDetails['name'] ?? '';
        profileController.userEmail.value = userDetails['email'] ?? '';
        profileController.userType.value = userDetails['userType'] ?? '';
      }
      Get.snackbar("Login Success", "Welcome back!");

      // Navigate to home or dashboard screen
      Get.offAllNamed(AppRoutes.homepageWithMenuScreen); // change this as needed

    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password.';
          break;
        default:
          message = e.message ?? 'Login failed';
      }
      Get.snackbar("Login Failed", message);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
