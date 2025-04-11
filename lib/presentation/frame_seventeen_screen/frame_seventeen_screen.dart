import 'package:flutter/material.dart'; 
import '../../core/app_export.dart';
import 'controller/frame_seventeen_controller.dart'; 
import 'models/contactinfolist_item_model.dart';
import 'widgets/contactinfolist_item_widget.dart'; // ignore_for_file: must_be_immutable
class FrameSeventeenScreen extends GetWidget<FrameSeventeenController> {
const FrameSeventeenScreen ({Key? key})
: super(
key: key,
);
@override
Widget build (BuildContext context) {
return Scaffold(
backgroundColor: theme.colorScheme.onPrimaryContainer, body: SafeArea( child: SizedBox(
width: double.maxFinite, child: Column ( spacing: 46, mainAxisSize: MainAxisSize.max,
crossAxisAlignment: CrossAxisAlignment.start, children: [_buildProfileSection(),_buildContactInfoList()],
),
),
),
);
}
/// Section Widget
Widget _buildProfileSection() {
return Container(
width: double.maxFinite, padding: EdgeInsets.only(
left: 16.h, top: 20.h, bottom: 20.h,
),
decoration: AppDecoration.fillLightGreen, child: Column(
crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
SizedBox(height: 2.h),
CustomImageView(
imagePath: ImageConstant.imgTempimagez2xc80,
height: 44.h, width: 46.h,
onTap: () {
  onTapImgTempimagez2xcei();
},
),
Container( margin: EdgeInsets.only(left: 66.h), decoration: AppDecoration.outlineBlack,
child: Text(
"Ibl_your_profile".tr, textAlign: TextAlign.center,
style: CustomTextStyles.displayMediumOnPrimaryContainer,
),
),
SizedBox(height: 46.h),
CustomImageView(
imagePath: ImageConstant.imgImageRemovebgPreview10,
height: 178.h, width: 196.h, margin: EdgeInsets.only(left: 102.h),
)
],
),
);
}
/// Section Widget
Widget _buildContactInfoList() {
return Padding (
padding: EdgeInsets.symmetric(horizontal: 24.h),
child: Obx(
() => ListView.separated(
padding: EdgeInsets.zero, physics: NeverScrollableScrollPhysics(),
shrinkWrap: true,
separatorBuilder: (context, index) {
return SizedBox(
height: 44.h,
);
},
itemCount: controller.frameSeventeenModelObj.value.contactinfolistItemList.value.length,
itemBuilder: (context, index) {
ContactinfolistItemModel model = controller.frameSeventeenModelObj.value.contactinfolistItemList.value[index];
return ContactinfolistItemWidget(
model,
);
},
),
),
);
}
onTapImgTempimagez2xcei(){
  Get.toNamed(AppRoutes.slideScreen,
  );
}
}