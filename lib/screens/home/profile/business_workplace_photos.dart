import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/image_picker_modal.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BusinessWorkplacePhotos extends StatefulWidget {
  const BusinessWorkplacePhotos({Key? key}) : super(key: key);

  @override
  State<BusinessWorkplacePhotos> createState() =>
      _BusinessWorkplacePhotosState();
}

class _BusinessWorkplacePhotosState extends State<BusinessWorkplacePhotos> {
  List<Color> mediaList = [];
  @override
  void initState() {
    super.initState();
    mediaList = [
      Colors.red,
      Colors.red,
      Colors.red,
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> mediaCards() {
      List<Widget> widgetList = mediaList.map((item) {
        return EaseInAnimation(
          beginAnimation: 0.98,
          onTap: () => {},
          child: Container(
            width: rSize(100),
            height: rSize(100),
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  rSize(10),
                ),
              ),
            ),
            child: Image.asset(
              'assets/images/avatar_female.png',
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList();
      widgetList.insert(
        0,
        EaseInAnimation(
          onTap: () => {
            showImagePickerModal(
                imagePickerModalProps: ImagePickerModalProps(
              context: context,
              saveImage: () => {},
            ))
          },
          beginAnimation: 0.98,
          child: DottedBorder(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderType: BorderType.RRect,
            dashPattern: [rSize(6), rSize(4)],
            strokeWidth: rSize(1),
            radius: Radius.circular(
              rSize(10),
            ),
            child: SizedBox(
              width: rSize(100),
              height: rSize(100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomIcon(
                    customIconProps: CustomIconProps(
                      icon: null,
                      backgroundColor: Colors.transparent,
                      path: 'assets/icons/camera.png',
                      containerSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: rSize(2),
                  ),
                  Text(
                    'Add Media',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontSize: rSize(12),
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

      return widgetList;
    }

    Widget renderMedia() {
      return Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        runSpacing: rSize(30),
        spacing: rSize(30),
        children: mediaCards(),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Workplace Photos',
          withBack: true,
          barHeight: 110,
          withClipPath: true,
          withSave: true,
          saveTap: () => {}, // here will add the save action
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(30),
          vertical: rSize(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Give clients a sneak peek of your space before they even walk through the door.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: rSize(40),
            ),
            renderMedia(),
          ],
        ),
      ),
    );
  }
}
