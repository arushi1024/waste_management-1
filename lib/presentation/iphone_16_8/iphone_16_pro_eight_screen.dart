import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/iphone_16_pro_eight_controller.dart'; // ignore_for_file: must_be_immutable

class Iphone16ProEightScreen extends GetWidget<Iphone16ProEightController> {
  const Iphone16ProEightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightGreen30001,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 106.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(flex: 51,),
              Text(
                "msg_complaint_filed".tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.displayMediumOnPrimaryContainer,
              ),
              Spacer(flex: 48,),
              CustomElevatedButton(
                height: 78.h,
                text: "lbl_go_back_home".tr,
                margin: EdgeInsets.only(left: 10.h, right: 6.h),
                onPressed: () {
                  onTapGobackhome();
                },
              ),
              SizedBox(height: 36.h),
              CustomElevatedButton(
                height: 74.h,
                text: "msg_file_another_complaint".tr,
                margin: EdgeInsets.only(left: 10.h, right: 6.h),
                onPressed: () {
                  onTapFileanother();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the homepageWithMenuScreen when the action is triggered.
  onTapGobackhome() {
    Get.toNamed(
      AppRoutes.homepageWithMenuScreen,
    );
  }

  /// Navigates to the iphonel6ProSevenScreen when the action is triggered.
  onTapFileanother() {
    Get.toNamed(
      AppRoutes.iphone16ProSevenScreen,
    );
  }
}
