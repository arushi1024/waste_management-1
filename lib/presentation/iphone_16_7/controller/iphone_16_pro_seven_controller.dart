// import 'package: flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:waste_management/presentation/iphone_16_7/models/iphone_16_pro_seven_model.dart'; 
import '../../../core/app_export.dart';
//import '../models/ iphone_16_pro_seven_model.dart';
/// A controller class for the Iphonel6ProSevenScreen.
///
/// This class manages the state of the Iphonel6ProSevenScreen, including the /// current iphonel6ProSevenModelObj
class Iphone16ProSevenController extends GetxController {
TextEditingController edittexttwoController = TextEditingController();
TextEditingController edittextoneController = TextEditingController();
Rx<Iphone16ProSevenModel> iphone16ProSevenModelObj = Iphone16ProSevenModel().obs;

@override
void onClose() {
super.onClose();
edittexttwoController.dispose();
edittextoneController.dispose();
}
}