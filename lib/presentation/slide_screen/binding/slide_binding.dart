import 'package:get/get.dart';

// import '//--/core/app_export.dart';
import '../controller/slide_controller.dart';
/// A binding class for the SlideScreen.
///
////This class ensures that the SlideController is created when the /// SlideScreen is first loaded. 
class SlideBinding extends Bindings {
@override
void dependencies () {
Get.lazyPut(() => SlideController());
}
}