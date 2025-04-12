import 'package:flutter/material.dart'; 
import '../../core/app_export.dart';
import 'controller/frame_seventeen_controller.dart'; 
 // ignore_for_file: must_be_immutable
class FrameSeventeenScreen extends GetWidget<FrameSeventeenController> {
const FrameSeventeenScreen ({Key? key})
: super(
key: key,
);
@override
Widget build (BuildContext context) {
return Scaffold(
backgroundColor: appTheme.whiteA700, body: SafeArea( child: SizedBox(
width: double.maxFinite, child: SingleChildScrollView ( child: SizedBox(width: double.maxFinite, child: Column(children: [_buildProfileSection(),SizedBox(height: 46.h,),_buildNameRow(),SizedBox(height: 40.h,),_buildEmailRow(),SizedBox(height: 84.h,),Text("lbl_version_1_0_0".tr,style: theme.textTheme.labelLarge,),SizedBox(height: 34.h,)],),),),),),);} 
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
Widget _buildNameRow(){
  return Container(
    width: double.maxFinite,
    margin: EdgeInsets.symmetric(horizontal: 36.h),
    child: Row(
      children: [
        CustomImageView(
          imagePath: ImageConstant.img1828439RemovebgPreview,
          height: 72.h,
          width: 90.h,
        ),
        Expanded(child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("lbl_name2".tr,
            style: theme.textTheme.bodyMedium,),
            Obx(() => Text(controller.userName.value,
            style: theme.textTheme.bodySmall,)), 
          ],
        ),
        )
      ],
    ),
  );
}
Widget _buildEmailRow(){
  return Container(
    width: double.maxFinite,
    margin: EdgeInsets.symmetric(horizontal: 36.h),
    child: Row(
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgImageRemovebgPreview12,
          height: 72.h,
          width: 90.h,
        ),
        Expanded(child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("lbl_email_id".tr,
            style: theme.textTheme.bodyMedium,
            ),
            Obx(()=> Text(controller.userEmail.value,
            style: theme.textTheme.bodySmall,))
          ],
        ),
        )
      ],
    ),
  );  
}
onTapImgTempimagez2xcei()
{
  Get.toNamed(
    AppRoutes.slideScreen,
  );
}  
}    