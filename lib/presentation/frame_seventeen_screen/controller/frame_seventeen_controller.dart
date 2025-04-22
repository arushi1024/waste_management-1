//import 'package:flutter/material.dart'; 
import 'package:waste_management/core/utils/shared_preferences_helper.dart';

import '../../../core/app_export.dart'; 
import '../models/frame_seventeen_model.dart';
/// A controller class for the FrameSeventeenScreen.
///
// This class manages the state of the FrameSeventeenScreen, including the /// current frameSeventeenModel0bj
class FrameSeventeenController extends GetxController {
Rx<FrameSeventeenModel> frameSeventeenModelObj = FrameSeventeenModel().obs;
RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxString userType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() async {
    final userDetails = await SharedPrefsHelper.getUserDetails();
    userName.value = userDetails['name'] ?? '';
    userEmail.value = userDetails['email'] ?? '';
    userType.value = userDetails['userType'] ?? '';
  }
}