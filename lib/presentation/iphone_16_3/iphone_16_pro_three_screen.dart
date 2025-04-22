import 'package:flutter/material.dart';
import 'package:waste_management/core/app_export.dart';
import 'package:waste_management/core/utils/validations_functions.dart';
import 'package:waste_management/theme/custom_button_style.dart';
import 'package:waste_management/widgets/custom_elevated_button.dart';
import 'package:waste_management/widgets/custom_radio_button.dart';
import 'package:waste_management/widgets/custom_text_form_field.dart';
import 'controller/iphone_16_pro_three_controller.dart';

// ignore_for_file: must_be_immutable
class Iphone16ProThreeScreen extends GetWidget<Iphone16ProThreeController> {
  Iphone16ProThreeScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 28.h, top: 58.h, right: 28.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: AppDecoration.outlineBlack,
                        child: Text(
                          "lbl_sign_up".tr,
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.headlineMediumBlack900_2,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Name Input Section
                    _buildNameInputSection(),
                    SizedBox(height: 16.h),
                    // Email Input Section
                    _buildEmailInputSection(),
                    SizedBox(height: 16.h),
                    // Password Input Section
                    _buildPasswordInputSection(),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.only(left: 14.h),
                      child: Text(
                        "msg_must_be_at_least".tr,
                        style: CustomTextStyles.bodyMediumRobotoBlack900,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.only(left: 18.h),
                      child: Text(
                        "lbl_you_are".tr,
                        style: CustomTextStyles.titleLargeGray900,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // User Type Selection
                    _buildUserTypeSelection(),
                    SizedBox(height: 22.h),
                    // Create Account Button
                    CustomElevatedButton(
                      text: "msg_create_an_account".tr.toUpperCase(),
                      margin: EdgeInsets.only(left: 8.h, right: 14.h),
                      buttonStyle: CustomButtonStyles.fillTeal,
                      buttonTextStyle: CustomTextStyles.titleLargeOnPrimaryContainer,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.signUpUser();
                        }
                      },
                    ),
                    SizedBox(height: 106.h),
                    // I Already Have an Account
                    GestureDetector(
                      onTap: () {
                        onTapTxtIAlreadyHaveAn2();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 32.h),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "msg_already_have_an".tr,
                                style: theme.textTheme.bodyLarge,
                              ),
                              TextSpan(
                                text: "lbl_log_in".tr,
                                style: theme.textTheme.titleMedium,
                              )
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameInputSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl_name".tr,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          CustomTextFormField(
            controller: controller.nametwoController,
            hintText: "lbl_enter_your_name".tr,
            validator: (value) {
              if (!isText(value)) {
                return "err_msg_please_enter_valid_text".tr;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInputSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "lbl_email".tr,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          CustomTextFormField(
            controller: controller.emailtwoController,
            hintText: "msg_enter_your_email".tr,
            textInputType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordInputSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl_password".tr,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          CustomTextFormField(
            controller: controller.passwordtwoController,
            hintText: "msg_create_a_password".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (value) {
              if (value == null || !isValidPassword(value, isRequired: true)) {
                return "err_msg_please_enter_valid_password".tr;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUserTypeSelection() {
    return Padding(
      padding: EdgeInsets.only(left: 14.h),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRadioButton(
              text: "Customer",
              value: "Customer",
              groupValue: controller.userTypeSelection.value,
              onChange: (value) {
                controller.userTypeSelection.value = value;
                controller.selectedBlock.value = "";
              },
            ),
            SizedBox(height: 12.h),
            CustomRadioButton(
              text: "Collector",
              value: "Collector",
              groupValue: controller.userTypeSelection.value,
              onChange: (value) {
                controller.userTypeSelection.value = value;
                controller.selectedBlock.value = "";
              },
            ),
            if (controller.userTypeSelection.value == "Customer") ...[
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Your Block',
                    border: OutlineInputBorder(),
                  ),
                  value: controller.selectedBlock.value.isNotEmpty
                      ? controller.selectedBlock.value
                      : null,
                  items: controller.blocks.map((block) {
                    return DropdownMenuItem<String>(
                      value: block,
                      child: Text(block),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedBlock.value = value;
                    }
                  },
                ),
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: controller.addressController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void onTapTxtIAlreadyHaveAn2() {
    Get.toNamed(AppRoutes.iphone16ProTwoScreen);
  }
}
