import 'dart:io';

import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/utils/layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/image_picker_modal.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/storage_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusinessCoverPhoto extends StatefulWidget {
  const BusinessCoverPhoto({Key? key}) : super(key: key);

  @override
  State<BusinessCoverPhoto> createState() => _BusinessCoverPhotoState();
}

class _BusinessCoverPhotoState extends State<BusinessCoverPhoto> {
  File? _imageFile;
  String imageUrl = '';
  bool _isLoading = true;
  bool isSaveDisabled = true;
  @override
  void initState() {
    super.initState();
    final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
    settingsMgr.getCoverImage().then(
          (url) => {
            if (url == 'notFound')
              {
                setState(
                  (() {
                    _isLoading = false;
                  }),
                ),
              }
            else
              setState(
                (() {
                  imageUrl = url;
                  _isLoading = false;
                }),
              ),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
    deleteImage() async {
      if (_imageFile != null) {
        setState(() {
          _isLoading = true;
        });
        await settingsMgr.deleteCoverImage().then(
              (value) => setState(
                (() {
                  _imageFile = null;
                  _isLoading = false;
                }),
              ),
            );
      }
    }

    deleteCoverPhoto() {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: 'Delete',
          secondaryButtonText: 'Back',
          deleteCancelModal: true,
          primaryAction: () async => {
            showLoaderDialog(context),
            await deleteImage(),
            Navigator.pop(context),
            showSuccessFlash(
              context: context,
              successColor: successPrimaryColor,
              successBody: 'Success',
              successTitle: 'Logo Photo Deleted Successfully.',
            ),
          },
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
                      ratioX: 16,
                      ratioY: 9,
                      isCircleCropStyle: false,
                      saveImage: (File? imageFile) {
                        setState(() {
                          _imageFile = imageFile;
                          isSaveDisabled = false;
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
                      height: rSize(225),
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
                    height: rSize(225),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(rSize(10)),
                      image: _imageFile == null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(imageUrl),
                            )
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(_imageFile!),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: rSize(40),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: rSize(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomButton(
                          customButtonProps: CustomButtonProps(
                            onTap: () => {
                              showImagePickerModal(
                                imagePickerModalProps: ImagePickerModalProps(
                                  context: context,
                                  isCircleCropStyle: false,
                                  ratioX: 16,
                                  ratioY: 9,
                                  saveImage: (File? imageFile) {
                                    setState(() {
                                      _imageFile = imageFile;
                                      isSaveDisabled = false;
                                    });
                                  },
                                ),
                              )
                            },
                            text: 'Edit Cover Photo',
                            isPrimary: true,
                          ),
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        CustomButton(
                          customButtonProps: CustomButtonProps(
                            onTap: () => {deleteCoverPhoto()},
                            text: 'Delete Cover Photo',
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      );
    }

    saveImage() async {
      if (_imageFile != null) {
        await settingsMgr.uploadCoverImage(_imageFile!);
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Cover Photo',
          withBack: true,
          barHeight: 110,
          withClipPath: true,
          withSave: true,
          withSaveDisabled: isSaveDisabled,
          saveTap: () async => {
            showLoaderDialog(context),
            await saveImage(),
            Navigator.pop(context),
            showSuccessFlash(
              context: context,
              successColor: successPrimaryColor,
              successBody: 'Success',
              successTitle: 'Cover Photo Uploaded Successfully.',
            ),
            setState(() {
              isSaveDisabled = true;
            })
          },
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
              height: rSize(80),
            ),
            _isLoading
                ? CustomLoadingIndicator(
                    customLoadingIndicatorProps: CustomLoadingIndicatorProps())
                : renderBusinessCoverPhoto(),
          ],
        ),
      ),
    );
  }
}
