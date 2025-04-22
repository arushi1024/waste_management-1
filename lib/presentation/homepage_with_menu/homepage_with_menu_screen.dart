import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:waste_management/widgets/complaints.dart';
import 'package:waste_management/widgets/fluttermap.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/homepage_with_menu_controller.dart'; // ignore_for_file: must_be_immutable
import 'package:permission_handler/permission_handler.dart';

class HomepageWithMenuScreen extends GetWidget<HomepageWithMenuController> {
  const HomepageWithMenuScreen({super.key});

  Future<List<Map<String, dynamic>>> fetchUserComplaints() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    final snapshot = await FirebaseFirestore.instance
        .collection('complaints')  // Corrected to 'complaints' to match the collection name
        .where('userId', isEqualTo: uid)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Existing Section (File a Complaint and Track Collector)
              CustomImageView(
                imagePath: ImageConstant.imgTempimage7v1c0j,
                height: 398.h,
                width: double.maxFinite,
              ),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 44.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.iphone16ProSevenScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 22.h),
                        child: Column(
                          spacing: 22,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgTempimageliwfil,
                              height: 94.h,
                              width: 94.h,
                              radius: BorderRadius.circular(4.h),
                              margin: EdgeInsets.only(left: 8.h, right: 12.h),
                            ),
                            Text(
                              "msg_file_a_complaint".tr,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        PermissionStatus status = await Permission.location.request();
                        // if (status.isGranted) {
                        //   Get.toNamed(AppRoutes.mapClientScreen); // Change this route if needed
                        // } else {
                        //   Get.snackbar('Permission Denied', 'Location access is required to track the collector.');
                        // }
                        Get.to(TrashCollectionMap());
                      },
                      child: SizedBox(
                        width: 158.h,
                        child: Column(
                          spacing: 22,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgTempimagelfdver,
                              height: 94.h,
                              width: 96.h,
                              margin: EdgeInsets.only(right: 14.h),
                            ),
                            Text(
                              "msg_track_my_collector".tr,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // New Section for "View My Complaints"
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (x) => ViewComplaintsScreen()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list_alt,  // Use an icon like 'list_alt' for complaints
                          size: 20.h,
                          color: const Color.fromARGB(255, 10, 240, 167),
                        ),
                        SizedBox(width: 10.h),
                        Text(
                          "View My Complaints",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 9, 232, 132),
                            fontSize: 16.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget: AppBar
  PreferredSizeWidget _buildAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(70.h),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.slideScreen);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                ImageConstant.imgTempimageymyxm5,
                height: 40.h,
                width: 40.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "👋 Hello!", // Could also be dynamic or localized
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "1bl_welcome".tr,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}
