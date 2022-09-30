import 'dart:io';

import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/image_picker_modal.dart';
import 'package:common_widgets/utils/layout.dart';animation.dart';
import 'package:common_widgets/image_picker_modal.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BusinessCoverPhoto extends StatefulWidget {
  const BusinessCoverPhoto({Key? key}) : super(key: key);

  @override
  State<BusinessCoverPhoto> createState() => _BusinessCoverPhotoState();
}

class _BusinessCoverPhotoState extends State<BusinessCoverPhoto> {
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    deleteCoverPhoto() {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: 'Delete',
          secondaryButtonText: 'Back',
          deleteCancelModal: true,
          primaryAction: () => {}, // delete action will be added here
          footerButton: ModalFooter.both,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIcon(
                customIconProps: CustomIconProps(
                  icon: null,
                  path: 'assets/icons/trash.png',
                  withPadding: true,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  iconColor: Colors.white,
                  containerSize: rSize(80),
                  contentPadding: rSize(20),
                ),
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                'Delete Cover Photo?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'Action can not be undone',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      );
    }

    Widget renderBusinessCoverPhoto() {
      return AnimatedSwitcher(
        reverseDuration: const Duration(milliseconds: 400),
        duration: const Duration(milliseconds: 400),
        child: _imageFile == null
            ? EaseInAnimation(
                onTap: () => {
                  showImagePickerModal(
                    imagePickerModalProps: ImagePickerModalProps(
                      context: context,
                      isCircleCropStyle: false,
                      saveImage: (File? imageFile) {
                        setState(() {
                          _imageFile = imageFile;
                        });
                      },
                    ),
                  )
                },
                beginAnimation: 0.98,
                child: Padding(
                  padding: EdgeInsets.only(right: rSize(20)),
                  child: DottedBorder(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
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
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    width: rSize(400),
                    height: rSize(200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(rSize(10)),
                      image: DecorationImage(
                        image: FileImage(
                          _imageFile!,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: rSize(40),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: rSize(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: CustomButton(
                            customButtonProps: CustomButtonProps(
                              onTap: () => {
                                showImagePickerModal(
                                  imagePickerModalProps: ImagePickerModalProps(
                                    context: context,
                                    isCircleCropStyle: false,
                                    saveImage: (File? imageFile) {
                                      setState(() {
                                        _imageFile = imageFile;
                                      });
                                    },
                                  ),
                                )
                              },
                              text: 'Edit Cover Photo',
                              isPrimary: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: rSize(40),
                        ),
                        Expanded(
                          child: CustomButton(
                            customButtonProps: CustomButtonProps(
                              onTap: () => {deleteCoverPhoto()},
                              text: 'Delete Cover Photo',
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Your cover photo is the first thing that your customers seen on your profile. Add a photo to give them  insight into what you are all about',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: rSize(100),
            ),
            renderBusinessCoverPhoto(),
          ],
        ),
      ),
    );
  }
}
