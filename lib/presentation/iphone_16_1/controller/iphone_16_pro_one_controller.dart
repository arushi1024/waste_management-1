import '../../../core/app_export.dart';
import '../models/iphone_16_pro_one_model.dart';

/// A controller class for the Iphone16ProOneScreen.
///
/// This class manages the state of the Iphone16ProOneScreen, including the
/// current iphone16ProOneModelObj.
class Iphone16ProOneController extends GetxController {
  Rx<Iphone16ProOneModel> iphone16ProOneModelObj = Iphone16ProOneModel().obs;

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offNamed(
        AppRoutes.iphone16ProThreeScreen,
      );
    });
  }
}
