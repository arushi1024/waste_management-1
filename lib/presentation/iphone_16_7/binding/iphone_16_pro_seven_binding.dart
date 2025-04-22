import 'package:get/get.dart';

//import ' ../../../core/app_export.dart';
import'../controller/iphone_16_pro_seven_controller.dart';
/// A binding class for the Iphonel6ProSevenScreen.
///
/// This class ensures that the Iphonel6ProSevenController is created when the /// Iphone16ProSevenScreen is first loaded.
class Iphone16ProSevenBinding extends Bindings {
@override
void dependencies () {
Get.lazyPut(() => Iphone16ProSevenController());
}
}