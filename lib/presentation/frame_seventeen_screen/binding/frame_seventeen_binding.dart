import '../../../core/app_export.dart';
import '../controller/frame_seventeen_controller.dart';
/// A binding class for the FrameSeventeenScreen.
///
/// This class ensures that the FrameSeventeenController is created when the /// FrameSeventeenScreen is first loaded.
class FrameSeventeenBinding extends Bindings {
@override
void dependencies () {
Get.lazyPut(() => FrameSeventeenController());
}
}