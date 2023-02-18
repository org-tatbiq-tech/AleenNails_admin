import 'dart:io';

import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/image_picker_modal.dart';
import 'package:common_widgets/placeholders.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/storage_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BusinessLogo extends StatefulWidget {
  const BusinessLogo({Key? key}) : super(key: key);

  @override
  State<BusinessLogo> createState() => _BusinessLogoState();
}

class _BusinessLogoState extends State<BusinessLogo> {
  File? _imageFile;
  bool _isLoading = true;
  bool isSaveDisabled = true;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    uploadLogo() async {
      showLoaderDialog(context);
      if (_imageFile != null) {
        File? imagePath = await compressImageNative(
          path: _imageFile!.absolute.path,
          quality: 80,
          targetWidth: 1000,
          targetHeight: 1000,
        );
        final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
        await settingsMgr.uploadLogoImage(imagePath!);
      }

      Navigator.pop(context);
      showSuccessFlash(
        context: context,
        successColor: successPrimaryColor,
        successBody:
            Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
        successTitle: Languages.of(context)!
            .logoPhotoUploadedSuccessfullyBody
            .toCapitalized(),
      );
      setState(() {
        isSaveDisabled = true;
      });
    }

    deleteImage() async {
      final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
      if (settingsMgr.profileManagement.profileMedia.logoURL != null &&
          settingsMgr.profileManagement.profileMedia.logoURL!.isNotEmpty) {
        setState(() {
          _isLoading = true;
        });
        await settingsMgr.deleteLogoImage();
        setState(
          (() {
            _isLoading = false;
          }),
        );
      } else if (_imageFile != null) {
        setState(() {
          _imageFile = null;
        });
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
                  containerSize: 80,
                  contentPadding: 20,
                ),
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                '${Languages.of(context)!.deleteLogoLabel.toTitleCase()}?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.actionUndoneLabel.toCapitalized(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }

    Widget renderBusinessLogo() {
      final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
      return AnimatedSwitcher(
        reverseDuration: const Duration(milliseconds: 400),
        duration: const Duration(milliseconds: 400),
        child: _imageFile == null &&
                settingsMgr.profileManagement.profileMedia.logoURL!.isEmpty
            ? Center(
                child: EaseInAnimation(
                  onTap: () => {
                    showImagePickerModal(
                      imagePickerModalProps: ImagePickerModalProps(
                        context: context,
                        cancelText:
                            Languages.of(context)!.cancelLabel.toTitleCase(),
                        deleteText:
                            Languages.of(context)!.deleteLabel.toTitleCase(),
                        takePhotoText:
                            Languages.of(context)!.takePhotoLabel.toTitleCase(),
                        libraryText: Languages.of(context)!
                            .chooseFromLibraryLabel
                            .toTitleCase(),
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
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
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
                              iconColor: Theme.of(context).colorScheme.primary,
                              containerSize: 70,
                            ),
                          ),
                          SizedBox(
                            height: rSize(5),
                          ),
                          Text(
                            Languages.of(context)!.addLogoLabel.toTitleCase(),
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _imageFile != null
                        ? Container(
                            width: rSize(160),
                            height: rSize(160),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(rSize(80)),
                              image: _imageFile == null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                        settingsMgr.profileManagement
                                            .profileMedia.logoURL!,
                                      ),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(_imageFile!),
                                    ),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: settingsMgr
                                .profileManagement.profileMedia.logoURL!,
                            imageBuilder: (context, imageProvider) => Container(
                              width: rSize(160),
                              height: rSize(160),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(rSize(80))),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor:
                                  Theme.of(context).colorScheme.background,
                              highlightColor:
                                  Theme.of(context).colorScheme.onBackground,
                              child: ImagePlaceHolder(
                                width: rSize(160),
                                height: rSize(160),
                                borderRadius: rSize(80),
                              ),
                            ),
                            // errorWidget: (context, url, error) => errorWidget,
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
                                  cancelText: Languages.of(context)!
                                      .cancelLabel
                                      .toTitleCase(),
                                  deleteText: Languages.of(context)!
                                      .deleteLabel
                                      .toTitleCase(),
                                  takePhotoText: Languages.of(context)!
                                      .takePhotoLabel
                                      .toTitleCase(),
                                  libraryText: Languages.of(context)!
                                      .chooseFromLibraryLabel
                                      .toTitleCase(),
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
                            isDisabled: settingsMgr
                                    .profileManagement.profileMedia.logoURL ==
                                null,
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

    return CustomContainer(
      imagePath: 'assets/images/background4.png',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: Languages.of(context)!.logoLabel.toTitleCase(),
            withBack: true,
            isTransparent: true,
            withSave: true,
            saveText: Languages.of(context)!.saveLabel,
            withSaveDisabled: isSaveDisabled,
            saveTap: () => uploadLogo(),
          ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _isLoading
              ? Center(
                  child: CustomLoadingIndicator(
                    customLoadingIndicatorProps: CustomLoadingIndicatorProps(),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: rSize(30),
                    vertical: rSize(50),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Languages.of(context)!.logoDescription.toCapitalized(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: rSize(40),
                      ),
                      renderBusinessLogo(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
