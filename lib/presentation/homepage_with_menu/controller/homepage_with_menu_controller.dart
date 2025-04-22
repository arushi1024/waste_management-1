// ignore: depend_on_referenced_packages
//import 'package: flutter/material.dart';
import '../../../core/app_export.dart'; 
import'../models/homepage_with_menu_model.dart';
/// A controller class for the HomepageWithMenuScreen.
///
/// This class manages the state of the HomepageWithMenuScreen, including the /// current homepageWithMenuMode lObj
class HomepageWithMenuController extends GetxController {
Rx<HomepageWithMenuModel> homepageWithMenuModelObj =
HomepageWithMenuModel().obs;
}