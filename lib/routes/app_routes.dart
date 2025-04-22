import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:waste_management/presentation/homepage_with_menu/binding/homepage_with_menu_binding.dart';
import 'package:waste_management/presentation/homepage_with_menu/homepage_with_menu_screen.dart';
import 'package:waste_management/presentation/iphone_16_1/binding/iphone_16_pro_one_binding.dart';
import 'package:waste_management/presentation/iphone_16_1/iphone_16_pro_one_screen.dart';
import 'package:waste_management/presentation/iphone_16_2/binding/iphone_16_pro_two_binding.dart';
import 'package:waste_management/presentation/iphone_16_2/iphone_16_pro_two_screen.dart';
import 'package:waste_management/presentation/iphone_16_3/binding/iphone_16_pro_three_binding.dart';
import 'package:waste_management/presentation/iphone_16_3/iphone_16_pro_three_screen.dart';
import 'package:waste_management/presentation/iphone_16_7/binding/iphone_16_pro_seven_binding.dart';
import 'package:waste_management/presentation/iphone_16_7/iphone_16_pro_seven_screen.dart';
import 'package:waste_management/presentation/iphone_16_8/binding/iphone_16_pro_eight_binding.dart';
import 'package:waste_management/presentation/iphone_16_8/iphone_16_pro_eight_screen.dart';
import 'package:waste_management/presentation/map_client/binding/map_client_binding.dart';
import 'package:waste_management/presentation/slide_screen/binding/slide_binding.dart';
import 'package:waste_management/presentation/map_client/controller/map_client_controller.dart';
import 'package:waste_management/presentation/map_client/map_client_screen.dart';
import 'package:waste_management/presentation/slide_screen/slide_screen.dart';
import 'package:waste_management/presentation/frame_seventeen_screen/binding/frame_seventeen_binding.dart';
import 'package:waste_management/presentation/frame_seventeen_screen/frame_seventeen_screen.dart';
import'package:waste_management/presentation/iphone_16_pro_twelve_screen/binding/iphone_16_pro_twelve_binding.dart';
import'package:waste_management/presentation/iphone_16_pro_twelve_screen/iphone_16_pro_twelve_screen.dart';
import '../core/app_export.dart';

import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String iphone16ProOneScreen = '/iphone_16_pro_one_screen';
  static const String iphone16ProThreeScreen = '/iphone_16_pro_three_screen';
  static const String iphone16ProTwoScreen = '/iphone_16_pro_two_screen';
  static const String homepageWithMenuScreen='/homepage_with_menu_screen';
  static const String iphone16ProSevenScreen='/iphone_16_pro_seven_screen';
  static const String iphone16ProEightScreen='/iphone_16_pro_eight_screen';
  static const String slideScreen='/slide_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/initialRoute';
  static const String frameSeventeenScreen ='/frame_seventeen_screen';
  static const String iphone16ProTwelveScreen ='/iphone_16_pro_twelve_screen';
  static const String mapClientScreen ='/map_client_screen';
  static const String viewComplaintsScreen = '/viewComplaintsScreen';

  static List<GetPage> pages = [
    GetPage(
      name: iphone16ProOneScreen,
      page: () => Iphone16ProOneScreen(),
      bindings: [Iphone16ProOneBinding()],
    ),
    GetPage(
      name: iphone16ProThreeScreen,
      page: () => Iphone16ProThreeScreen(),
      bindings: [Iphone16ProThreeBinding()],
    ),
    GetPage(
      name: iphone16ProTwoScreen,
      page: () => Iphone16ProTwoScreen(),
      bindings: [Iphone16ProTwoBinding()],
    ),
    GetPage(
      name: homepageWithMenuScreen,
      page: () => HomepageWithMenuScreen(),
      bindings: [HomepageWithMenuBinding()],
    ),
    GetPage(
      name: iphone16ProSevenScreen,
      page: () => Iphone16ProSevenScreen(),
      bindings: [Iphone16ProSevenBinding()],
    ),
    GetPage(
      name: iphone16ProEightScreen,
      page: () => Iphone16ProEightScreen(),
      bindings: [Iphone16ProEightBinding()],
    ),
    GetPage(
      name: slideScreen,
      page: () => SlideScreen(),
      bindings: [SlideBinding()],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationsGreen(),
      bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: frameSeventeenScreen,
      page: () => FrameSeventeenScreen(),
      bindings: [FrameSeventeenBinding()],
    ),
    GetPage(
      name: iphone16ProTwelveScreen,
      page: () => Iphone16ProTwelveScreen(),
      bindings: [Iphone16ProTwelveBinding()],
    ),
    GetPage(
      name: initialRoute,
      page: () => Iphone16ProOneScreen(),
      bindings: [Iphone16ProOneBinding()],
    ),
    GetPage(
      name: mapClientScreen,
      page: () => MapClientScreen(),
      bindings: [MapClientBinding()],
    ),
  ];
}
