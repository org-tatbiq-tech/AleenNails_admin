import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:appointments/widget/image_picker_modal.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BusinessCoverPhoto extends StatelessWidget {
  const BusinessCoverPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _renderBusinessCoverPhoto() {
      return EaseInAnimation(
        onTap: () => {
          showImagePickerModal(
            imagePickerModalProps: ImagePickerModalProps(
              context: context,
              saveImage: () => {},
            ),
          )
        },
        beginAnimation: 0.98,
        child: Padding(
          padding: EdgeInsets.only(right: rSize(20)),
          child: DottedBorder(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
            borderType: BorderType.RRect,
            dashPattern: [rSize(6), rSize(4)],
            strokeWidth: rSize(1),
            radius: Radius.circular(
              rSize(10),
            ),
            child: SizedBox(
              width: rSize(400),
              height: rSize(200),
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
                      containerSize: 80,
                    ),
                  ),
                  SizedBox(
                    height: rSize(2),
                  ),
                  Text(
                    'Add Cover Photo',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontSize: rSize(16),
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Cover Photo',
          withBack: true,
          barHeight: 110,
          withClipPath: true,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your cover photo is the first thing that your customers seen on your profile. Add a photo to give them  insight into what you are all about',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: rSize(180),
            ),
            _renderBusinessCoverPhoto(),
          ],
        ),
      ),
    );
  }
}
