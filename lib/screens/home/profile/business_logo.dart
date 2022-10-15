import 'dart:io';

import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/utils/general.dart';
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
  String imageUrl = '';
  bool _isLoading = true;
  bool isSaveDisabled = true;
  @override
  void initState() {
    super.initState();
    final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
    try {
      settingsMgr.getLogoImage().then(
            (url) => {
              if (url == 'notFound')
                {
                  if (mounted)
                    {
                      setState(
                        (() {
                          _isLoading = false;
                        }),
                      ),
                    }
                }
              else
                {
                  if (mounted)
                    {
                      setState(
                        (() {
                          imageUrl = url;
                          _isLoading = false;
                        }),
                      ),
                    }
                },
            },
          );
    } catch (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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

    deleteImage() async {
      if (_imageFile != null) {
        final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
        setState(() {
          _isLoading = true;
        });
        await settingsMgr.deleteLogoImage().then(
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
          primaryButtonText: Languages.of(context)!.deleteLabel.toTitleCase(),
          secondaryButtonText: Languages.of(context)!.backLabel.toTitleCase(),
          deleteCancelModal: true,
          primaryAction: () async => {
            showLoaderDialog(context),
            await deleteImage(),
            Navigator.pop(context),
            showSuccessFlash(
              context: context,
              successColor: successPrimaryColor,
              successBody:
                  Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
              successTitle: Languages.of(context)!
                  .logoPhotoDeletedSuccessfullyBody
                  .toCapitalized(),
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
                '${Languages.of(context)!.deleteLogoLabel.toTitleCase()}?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.actionUndoneLabel.toCapitalized(),
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
        child: _imageFile == null && imageUrl.isEmpty
            ? EaseInAnimation(
                onTap: () => {
                  showImagePickerModal(
                    imagePickerModalProps: ImagePickerModalProps(
                      context: context,
                      isCircleCropStyle: true,
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
                          Languages.of(context)!.addLogoLabel.toTitleCase(),
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
                                  isCircleCropStyle: true,
                                  saveImage: (File? imageFile) {
                                    setState(() {
                                      _imageFile = imageFile;
                                      isSaveDisabled = false;
                                    });
                                  },
                                ),
                              )
                            },
                            text: Languages.of(context)!
                                .editLogoLabel
                                .toTitleCase(),
                            isPrimary: true,
                          ),
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        CustomButton(
                          customButtonProps: CustomButtonProps(
                            onTap: () => {deleteLogo()},
                            text: Languages.of(context)!
                                .deleteLogoLabel
                                .toTitleCase(),
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
          titleText: Languages.of(context)!.logoLabel.toTitleCase(),
          withBack: true,
          barHeight: 110,
          withClipPath: true,
          withSave: true,
          saveText: Languages.of(context)!.saveLabel,
          withSaveDisabled: isSaveDisabled,
          saveTap: () async => {
            showLoaderDialog(context),
            await saveImage(),
            Navigator.pop(context),
            showSuccessFlash(
              context: context,
              successColor: successPrimaryColor,
              successBody:
                  Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
              successTitle: Languages.of(context)!
                  .logoPhotoUploadedSuccessfullyBody
                  .toCapitalized(),
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
            Column(
              children: [
                Text(
                  Languages.of(context)!.logoDescription.toCapitalized(),
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
