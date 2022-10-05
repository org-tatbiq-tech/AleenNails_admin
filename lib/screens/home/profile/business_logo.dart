import 'dart:io';

import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/utils/layout.dart';
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

class BusinessLogo extends StatefulWidget {
  const BusinessLogo({Key? key}) : super(key: key);

  @override
  State<BusinessLogo> createState() => _BusinessLogoState();
}

class _BusinessLogoState extends State<BusinessLogo> {
  File? _imageFile;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
    try {
      settingsMgr.getLogoImage().then(
            (imageUrl) => {
              if (imageUrl == 'notFound')
                {
                  setState(
                    (() {
                      _isLoading = false;
                    }),
                  ),
                }
              else
                {
                  fileFromImageUrl('logo', imageUrl).then(
                    (value) => setState(
                      (() {
                        _imageFile = value;
                        _isLoading = false;
                      }),
                    ),
                  ),
                },
            },
          );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    saveImage() async {
      if (_imageFile != null) {
        final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
        await settingsMgr.uploadLogoImage(_imageFile!);
      }
    }

    deleteImage() {
      if (_imageFile != null) {
        final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
        setState(() {
          _isLoading = true;
        });
        settingsMgr.deleteLogoImage().then(
              (value) => setState(
                (() {
                  _imageFile = null;
                  _isLoading = false;
                }),
              ),
            );
      }
    }

    deleteLogo() {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: 'Delete',
          secondaryButtonText: 'Back',
          deleteCancelModal: true,
          primaryAction: () => {deleteImage()},
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
                'Delete Logo?',
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

    Widget renderBusinessLogo() {
      return AnimatedSwitcher(
        reverseDuration: const Duration(milliseconds: 400),
        duration: const Duration(milliseconds: 400),
        child: _imageFile == null
            ? EaseInAnimation(
                onTap: () => {
                  showImagePickerModal(
                    imagePickerModalProps: ImagePickerModalProps(
                      context: context,
                      isCircleCropStyle: true,
                      saveImage: (File? imageFile) {
                        setState(() {
                          _imageFile = imageFile;
                        });
                      },
                    ),
                  )
                },
                beginAnimation: 0.98,
                child: DottedBorder(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  borderType: BorderType.Circle,
                  dashPattern: [rSize(6), rSize(4)],
                  strokeWidth: rSize(1),
                  radius: Radius.circular(
                    rSize(10),
                  ),
                  child: SizedBox(
                    width: rSize(160),
                    height: rSize(160),
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
                            containerSize: 70,
                          ),
                        ),
                        SizedBox(
                          height: rSize(5),
                        ),
                        Text(
                          'Add Logo',
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    width: rSize(160),
                    height: rSize(160),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(rSize(80)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
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
                                  isCircleCropStyle: true,
                                  saveImage: (File? imageFile) {
                                    setState(() {
                                      _imageFile = imageFile;
                                    });
                                  },
                                ),
                              )
                            },
                            text: 'Edit Logo',
                            isPrimary: true,
                          ),
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        CustomButton(
                          customButtonProps: CustomButtonProps(
                            onTap: () => {deleteLogo()},
                            text: 'Delete Logo',
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

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Logo',
          withBack: true,
          barHeight: 110,
          withClipPath: true,
          withSave: true,
          saveTap: () async => {
            showLoaderDialog(context),
            await saveImage(),
            Navigator.pop(context),
            showSuccessFlash(
              context: context,
              successColor: successPrimaryColor,
              successBody: 'Success',
              successTitle: 'Logo Uploaded Successfully.',
            ),
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
            Column(
              children: [
                Text(
                  'Upload your business logo so its visible on your profile.',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: rSize(40),
                ),
              ],
            ),
            _isLoading
                ? CustomLoadingIndicator(
                    customLoadingIndicatorProps: CustomLoadingIndicatorProps())
                : renderBusinessLogo(),
          ],
        ),
      ),
    );
  }
}
