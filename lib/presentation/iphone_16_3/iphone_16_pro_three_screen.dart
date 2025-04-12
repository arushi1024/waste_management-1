import 'package:flutter/material.dart';
import 'package:waste_management/core/app_export.dart';
import 'package:waste_management/core/utils/validations_functions.dart';
import 'package:waste_management/theme/custom_button_style.dart';
import 'package:waste_management/widgets/custom_elevated_button.dart';
import 'package:waste_management/widgets/custom_radio_button.dart';
import 'package:waste_management/widgets/custom_text_form_field.dart';
//import './../theme/custom_button_style.dart';
// import './../widgets/custom_elevated_button.dart';
// import './../widgets/custom_radio_button.dart';
// import './../widgets/custom_text_form_field.dart';
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
                    _buildNameInputSection(),
                    _buildEmailInputSection(),
                    _buildPasswordInputSection(),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(left: 14.h),
                      child: Text(
                        "msg_must_be_at_least".tr,
                        style: CustomTextStyles.bodyMediumRobotoBlack900,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(left: 18.h),
                      child: Text(
                        "lbl_you_are".tr,
                        style: CustomTextStyles.titleLargeGray900,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    _buildUserTypeSelection(),
                    SizedBox(height: 22.h),
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
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6.h),
            child: Text(
              "lbl_name".tr,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          CustomTextFormField(
            controller: controller.nametwoController,
            hintText: "lbl_enter_your_name".tr,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.h),
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
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Column(
        spacing: 6,
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
            contentPadding: EdgeInsets.symmetric(horizontal: 12.h,vertical: 16.h),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordInputSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 12.h),
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
            contentPadding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.h),
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
          children: [
            CustomRadioButton(
              text: "lbl_customer".tr.toUpperCase(),
              value: "lbl_customer".tr,
              groupValue: controller.userTypeSelection.value,
              onChange: (value) {
                controller.userTypeSelection.value = value;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 14.h),
              child: CustomRadioButton(
                text: "lbl_collector".tr.toUpperCase(),
                value: "lbl_collector".tr,
                groupValue: controller.userTypeSelection.value,
                onChange: (value) {
                  controller.userTypeSelection.value = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapTxtIAlreadyHaveAn2() {
    Get.toNamed(AppRoutes.iphone16ProTwoScreen);
  }
}