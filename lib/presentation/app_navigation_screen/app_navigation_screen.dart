import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/app_navigation_controller.dart'; // ignore_for_file: must_be_immutable

class AppNavigationsGreen extends GetWidget<AppNavigationController> {
  const AppNavigationsGreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SizedBox(
          width: 375.0,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "App Navigation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFB88888),
                          fontSize: 20.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Check your app's UI from the below demo screens of your app.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFB88888),
                          fontSize: 16.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: Color(0xFF000000),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              _buildScreenTitle(
                                screenTitle: "iPhone 16 Pro - One",
                                onTapScreenTitle: () =>
                                    onTapScreenTitle(AppRoutes.iphone16ProOneScreen),
                              ),
                              _buildScreenTitle(
                                screenTitle: "iPhone 16 Pro - Three",
                                onTapScreenTitle: () =>
                                    onTapScreenTitle(AppRoutes.iphone16ProThreeScreen),
                              ),
                              _buildScreenTitle(
                                screenTitle: "iPhone 16 Pro - Two",
                                onTapScreenTitle: () =>
                                    onTapScreenTitle(AppRoutes.iphone16ProTwoScreen),
                              ), _buildScreenTitle(
                                screenTitle: "HomePage with Menu",
                                onTapScreenTitle: () =>
                                    onTapScreenTitle(AppRoutes.homepageWithMenuScreen),
                              ),
                              _buildScreenTitle(
                                screenTitle: "iPhone 16 Pro - Seven",
                                onTapScreenTitle: () =>
                                    onTapScreenTitle(AppRoutes.iphone16ProSevenScreen),
                              ),
                              _buildScreenTitle(
                                screenTitle: "iPhone 16 Pro - Eight",
                                onTapScreenTitle: () =>
                                    onTapScreenTitle(AppRoutes.iphone16ProEightScreen),
                              ),
                              _buildScreenTitle(
                                screenTitle: "Slide Screen",
                                onTapScreenTitle: () =>
                                    onTapScreenTitle(AppRoutes.slideScreen),
                              ),
                              _buildScreenTitle(
                                screenTitle: "Frame Seventeen",
                                onTapScreenTitle: () =>
                                    onTapScreenTitle(AppRoutes.frameSeventeenScreen),
                              ),
                              _buildScreenTitle(
                                screenTitle: "Iphone 16 Pro - Twelve",
                                onTapScreenTitle: () =>
                                    onTapScreenTitle(AppRoutes.iphone16ProTwelveScreen),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Common widget for screen titles
  Widget _buildScreenTitle({
    required String screenTitle,
    required Function onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                screenTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            SizedBox(height: 5.0),
            Divider(
              height: 1.0,
              thickness: 1.0,
              color: Color(0xFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common navigation function
  void onTapScreenTitle(String routeName) {
    Get.toNamed(routeName);
  }
}
