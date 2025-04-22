// import 'package: flutter/material.dart';
import 'package:get/get.dart';
import 'package:waste_management/presentation/slide_screen/models/slide_model.dart';
//import 'package:waste_management/presentation/slide_screen/models/sliding_model.dart'; 
import '../../../core/app_export.dart'; 
// import '../models/slide_model.dart';
/// A controller class for the SlideScreen.
///
/// This class manages the state of the SlideScreen, including the /// current slideModelObj
class SlideController extends GetxController {
Rx<SlideModel> slideModelObj = SlideModel().obs;
}