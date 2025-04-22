import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import 'controller/iphone_16_pro_one_controller.dart'; 

// ignore_for_file: must_be_immutable
class Iphone16ProOneScreen extends GetWidget<Iphone16ProOneController> {
  const Iphone16ProOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Iphone16ProOneScreen is working");
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 44.h,
            top: 232.h,
            right: 44.h,
          ),
          child: Column(
            spacing: 18,
            mainAxisSize: MainAxisSize.max,
            children: [ CustomImageView( imagePath: ImageConstant.imgImage1, height: 150.h, width: double.maxFinite,),
              Text(
                "lbl_loading".tr,
                style: CustomTextStyles.bodyMedium14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
