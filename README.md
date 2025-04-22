# waste_management

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Try this for slide screen page:
```dart
Text(
  "Ibl_welcome".tr,
  textAlign: TextAlign.left,
  style: theme.textTheme.displayMedium,
  overflow: TextOverflow.clip,
  maxLines: 1,
)
```
For icons in slide screen:
```dart
Widget _buildHorizontalScrollSection() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: IntrinsicWidth(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 72.h,
              height: 72.h,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(), // Needed for clipBehavior to work
              child: CustomImageView(
                imagePath: ImageConstant.imgTempimagelfdver,
                height: 100.h, // intentionally larger to demonstrate clipping
                width: 100.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 18), // was `spacing: 18`, replaced with SizedBox
            Text(
              "msg_track_my_collector".tr,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    ),
  );
}
```
Or you can try this
```dart
Widget _buildHorizontalScrollSection() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: IntrinsicWidth(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 72.h,
              height: 72.h,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(),
              child: CustomImageView(
                imagePath: ImageConstant.imgTempimagelfdver,
                height: 100.h,
                width: 100.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 18),
            Container(
              width: 72.h, // match the width of the image
              child: Text(
                "msg_track_my_collector".tr,
                style: theme.textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
```



