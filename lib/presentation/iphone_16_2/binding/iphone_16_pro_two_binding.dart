import '../../../core/app_export.dart';
import '../controller/iphone_16_pro_two_controller.dart';

/// A binding class for the Iphone16ProTwoScreen.
///
/// This class ensures that the Iphone16ProTwoController is created when the
/// Iphone16ProTwoScreen is first loaded.
class Iphone16ProTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Iphone16ProTwoController());
  }
}
