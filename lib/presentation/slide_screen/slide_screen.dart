import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../core/app_export.dart';
import 'controller/slide_controller.dart'; // ignore_for_file: must_be_immutable

class SlideScreen extends GetWidget<SlideController> {
  const SlideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightGreen30001,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 68.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 24.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180.h,
                      child: Column(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgTempimageke5ir3,
                            height: 40.h,
                            width: 42.h,
                            alignment: Alignment.centerLeft,
                            onTap: () {
             // Navigate back to the home page
                   Get.toNamed(AppRoutes.homepageWithMenuScreen);
               // Alternatively, if you want to go back to the previous screen:
               // Get.back();
                           },
                          ),
                          SizedBox(height: 68.h),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgTempimagelntocy,
                                height: 26.h,
                                width: 26.h,
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.only(bottom: 8.h),
                              ),
                              Text(
                                "Ibl profile".tr,
                                style: theme.textTheme.displaySmall,
                              ),
                            ],
                          ),
                          SizedBox(height: 18.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgTempimagebtindv,
                                height: 30.h,
                                width: 30.h, //both were 24
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.h),
                                child: Text(
                                  "Ibl_about_us".tr,
                                  style: theme.textTheme.headlineLarge,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 584.h,
                          margin: EdgeInsets.only(top: 38.h),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 554.h,
                                  width: 226.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.lime200,
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(20.h),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(left: 32.h),
                                padding: EdgeInsets.only(top: 32.h),
                                decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
                                  borderRadius: BorderRadiusStyle.customBorderTL20,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(height: 6.h),
                                    SizedBox(
                                      height: 364.h,
                                      width: double.maxFinite,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          CustomImageView(
                                            imagePath: ImageConstant.imgTempimage7v1c0j308x228,
                                            height: 308.h,
                                            width: double.maxFinite,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              width: double.infinity, // or a specific width like 200.w
                                              padding: EdgeInsets.symmetric(horizontal: 12),
                                              decoration: AppDecoration.outlineBlack,
                                              child: Text(
                                                "Ibl_welcome".tr,
                                                textAlign: TextAlign.left,
                                                style: theme.textTheme.displayMedium,
                                                overflow: TextOverflow.clip,
                                                maxLines: 1,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              width: double.maxFinite,
                                              padding: EdgeInsets.only(right: 20.h),
                                              child: Column(
                                                spacing: 18,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  CustomImageView(
                                                    imagePath: ImageConstant.imgTempimageliwfil72x72,
                                                    height: 72.h,
                                                    width: 74.h,
                                                    radius: BorderRadius.circular(3.h),
                                                    margin: EdgeInsets.only(right: 6.h),
                                                  ),
                                                  Text(
                                                    "msg_file_a_complaint".tr,
                                                    style: theme.textTheme.bodySmall,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    softWrap: false,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          _buildHorizontalScrollSection()
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 38.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHorizontalScrollSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: IntrinsicWidth(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            spacing: 18,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgTempimagelfdver,
                height: 72.h,
                width: 72.h,
              ),
              Text(
                "msg_track_my_collector".tr,
                style: theme.textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}



