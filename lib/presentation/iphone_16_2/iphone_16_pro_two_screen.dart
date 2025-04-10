import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/app_export.dart';
import 'package:waste_management/core/utils/validations_functions.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/iphone_16_pro_two_controller.dart';

// ignore_for_file: must_be_immutable
class Iphone16ProTwoScreen extends GetWidget<Iphone16ProTwoController> {
  Iphone16ProTwoScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(40.h),
            child: Column(
              children: [
                Container(
                  decoration: AppDecoration.outlineBlack,
                  child: Text(
                    "lbl_log_in".tr,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.headlineMediumBlack900_2,
                  ),
                ),
                SizedBox(height: 62.h),
                _buildLoginForm(),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Email field
  Widget _buildEmailInputField() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_email2".tr,
            style: CustomTextStyles.bodyLargeInterOnSecondaryContainer,
          ),
          CustomTextFormField(
            controller: controller.emailController,
            hintText: "lbl_value".tr,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 8.h,
            ),
            borderDecoration: TextFormFieldStyleHelper.outlineBlueGray,
          ),
        ],
      ),
    );
  }

  /// Password field
  Widget _buildPasswordInputField() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_password2".tr,
            style: CustomTextStyles.bodyLargeInterOnSecondaryContainer,
          ),
          CustomTextFormField(
            controller: controller.passwordController,
            hintText: "lbl_value".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 8.h,
            ),
            borderDecoration: TextFormFieldStyleHelper.outlineBlueGray,
            validator: (value) {
              if (value == null || (!isValidPassword(value, isRequired: true))) {
                return "err_msg_please_enter_valid_password".tr;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  /// Login form with Sign In and Forgot Password
  Widget _buildLoginForm() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(22.h),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEmailInputField(),
          SizedBox(height: 24.h),
          _buildPasswordInputField(),
          SizedBox(height: 24.h),
          CustomOutlinedButton(
            height: 40.h,
            text: "lbl_sign_in".tr,
            buttonTextStyle: CustomTextStyles.bodyLargeInterOnError,
            onPressed: () {
              onTapSignin();
            },
          ),
          SizedBox(height: 16.h),

          /// 👇 Forgot Password clickable text
          GestureDetector(
            onTap: _showForgotPasswordDialog,
            child: Text(
              "msg_forgot_password".tr,
              style: CustomTextStyles.bodyLargeInterOnSecondaryContainer.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Sign-in button action
  onTapSignin() {
    if (_formKey.currentState!.validate()) {
      controller.loginUser();
    }
  }

  /// 👇 Forgot Password dialog and Firebase action
  void _showForgotPasswordDialog() {
    final TextEditingController forgotEmailController = TextEditingController();

    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('Reset Password'),
          content: TextField(
            controller: forgotEmailController,
            decoration: InputDecoration(hintText: "Enter your email"),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final email = forgotEmailController.text.trim();
                if (email.isEmpty) {
                  Get.snackbar("Input Error", "Please enter your email");
                  return;
                }

                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                  Get.back(); // Close the dialog
                  Get.snackbar("Success", "Password reset email sent!");
                } on FirebaseAuthException catch (e) {
                  Get.snackbar("Error", e.message ?? "Failed to send reset email");
                }
              },
              child: Text("Send"),
            ),
          ],
        );
      },
    );
  }
}
