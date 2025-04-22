import 'package:get/get.dart';

import '../../../core/app_export.dart';
import '../controller/homepage_with_menu_controller.dart';
/// A binding class for the HomepageWithMenuScreen.
///
// This class ensures that the HomepageWithMenuController is created when the /// HomepageWithMenuScreen is first loaded.
class HomepageWithMenuBinding extends Bindings {
@override
void dependencies() {
Get.lazyPut(() => HomepageWithMenuController());
}
}