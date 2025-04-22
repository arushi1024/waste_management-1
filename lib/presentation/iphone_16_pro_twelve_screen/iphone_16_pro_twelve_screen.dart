import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/iphone_16_pro_twelve_controller.dart'; // ignore_for_file: must_be_immutable

class Iphone16ProTwelveScreen extends GetWidget<Iphone16ProTwelveController> {
  const Iphone16ProTwelveScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: theme.colorScheme.onPrimaryContainer.withValues(
        alpha: 0.6,
      ),
      body: Container(
        width: double.maxFinite,
        height: SizeUtils.height,
        decoration: AppDecoration.fillOnPrimaryContainer1,
        child: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 12.h, top: 50.h, right: 12.h),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(left: 8.h),
                      child: Column(
                        spacing: 76,
                        children: [
                          Text(
                            "Ibl_about_us2".tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.displayMediumKaiseiTokumin,
                          ),
                          Text(
                            "msg_bengaluru_s_waste".tr,
                            maxLines: 17,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium,
                          ),
                          CustomElevatedButton(
                            height: 54.h,
                            text: "1bl_home".tr,
                            margin: EdgeInsets.only(left: 90.h, right: 82.h),
                            buttonStyle:
                                CustomButtonStyles.fillOnPrimaryContainer,
                            buttonTextStyle:
                                CustomTextStyles.headlineSmallBlack900,
                            onPressed: () {
                              onTapHomeButton();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates to the homepageWithMenuScreen when the action is triggered.
  onTapHomeButton() {
    Get.toNamed(AppRoutes.homepageWithMenuScreen);
  }
}
