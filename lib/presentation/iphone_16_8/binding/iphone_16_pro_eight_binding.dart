import 'package:get/get.dart';

import '../../../core/app_export.dart';
import'../controller/iphone_16_pro_eight_controller.dart';
/// A binding class for the Iphonel6ProEightScreen.
///
/// This class ensures that the Iphonel6ProEightController is created when the /// Iphonel6ProEightScreen is first loaded.
class Iphone16ProEightBinding extends Bindings {
@override
void dependencies () {
Get.lazyPut(() => Iphone16ProEightController ());
}
}