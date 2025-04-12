import 'package:flutter/material.dart';
// Assuming you're using GetX

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/iphone_16_pro_seven_controller.dart'; // ignore_for_file: must_be_immutable

class Iphone16ProSevenScreen extends GetWidget<Iphone16ProSevenController> {
  const Iphone16ProSevenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(left: 18.h, top: 8.h, right: 18.h),
              child: Column(
                children: [
                  Container(
                    decoration: AppDecoration.outlineBlack,
                    child: Text(
                      "msg_file_a_complaint2".tr,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.displayMedium,
                    ),
                  ),
                  SizedBox(height: 56.h),
                  _buildVehicleNumberSection(),
                  SizedBox(height: 70.h),
                  _buildComplaintReasonSection(),
                  SizedBox(height: 90.h),
                  CustomElevatedButton(
                    height: 56.h,
                    text: "1bl_submit2".tr,
                    margin: EdgeInsets.only(left: 10.h, right: 22.h),
                    buttonStyle: CustomButtonStyles.fillLightGreen,
                    buttonTextStyle: CustomTextStyles.headlineMediumBlack900_1,
                    onPressed: (){
                      Get.toNamed(AppRoutes.iphone16ProEightScreen);
                    },
                  ),
                  SizedBox(height: 54.h,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  /// Builds the AppBar widget.
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 72.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgTempimagez2xc80,
        height: 44.h,
        width: 44.h,
        margin: EdgeInsets.only(left: 18.h),
        onTap: () {
          onTapTempimagez2xcei();
        },
      ),
    );
  }

  /// Builds the vehicle number section.
  Widget _buildVehicleNumberSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 10.h),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ibl_vehicle_number".tr,
            style: CustomTextStyles.headlineMediumBlack90026,
          ),
          CustomTextFormField(
            controller: controller.edittexttwoController,
            contentPadding: EdgeInsets.all(12.h),
            borderDecoration: TextFormFieldStyleHelper.outlineBlackTL6,
            fillColor: appTheme.whiteA70001,
          ),
        ],
      ),
    );
  }

  /// Builds the complaint reason section.
  Widget _buildComplaintReasonSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        spacing: 2,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "msg_reason_for_complaint".tr,
            style: CustomTextStyles.headlineMediumBlack900,
          ),
          CustomTextFormField(
            controller: controller.edittextoneController,
            textInputAction: TextInputAction.done,
            maxLines: 6,
            contentPadding: EdgeInsets.all(12.h),
            borderDecoration: TextFormFieldStyleHelper.outlineBlackLR8,
          ),
        ],
      ),
    );
  }

  /// Navigates to the homepageWithMenuScreen when the action is triggered.
  void onTapTempimagez2xcei() {
    Get.toNamed(AppRoutes.homepageWithMenuScreen);
  }
}