import 'dart:io';

import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom/custom_container.dart';
import 'package:common_widgets/placeholders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/image_picker_modal.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/storage_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BusinessCoverPhoto extends StatefulWidget {
  const BusinessCoverPhoto({Key? key}) : super(key: key);

  @override
  State<BusinessCoverPhoto> createState() => _BusinessCoverPhotoState();
}

class _BusinessCoverPhotoState extends State<BusinessCoverPhoto> {
  File? _imageFile;
  bool isSaveDisabled = true;

  @override
  Widget build(BuildContext context) {
    final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);

    deleteImage() async {
      if (settingsMgr.profileManagement.profileMedia.coverURL!.isNotEmpty) {
        showLoaderDialog(context);
        await settingsMgr.deleteCoverImage();
        showSuccessFlash(
          context: context,
          successColor: successPrimaryColor,
          successBody:
              Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
          successTitle: Languages.of(context)!
              .coverPhotoPhotoUploadedSuccessfullyBody
              .toCapitalized(),
        );
        Navigator.pop(context);
      }
    }

    deleteCoverPhoto() {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.deleteLabel,
          secondaryButtonText: Languages.of(context)!.backLabel,
          deleteCancelModal: true,
          primaryAction: () => {
            deleteImage(),
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
                '${Languages.of(context)!.deleteCoverPhotoLabel.toCapitalized()}?',
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

    Widget renderBusinessCoverPhoto() {
      return AnimatedSwitcher(
        reverseDuration: const Duration(milliseconds: 400),
        duration: const Duration(milliseconds: 400),
        child: _imageFile == null &&
                settingsMgr.profileManagement.profileMedia.coverURL!.isEmpty
            ? EaseInAnimation(
                onTap: () => {
                  showImagePickerModal(
                    imagePickerModalProps: ImagePickerModalProps(
                      context: context,
                      ratioX: 16,
                      ratioY: 9,
                      isCircleCropStyle: false,
                      cancelText:
                          Languages.of(context)!.cancelLabel.toTitleCase(),
                      deleteText:
                          Languages.of(context)!.deleteLabel.toTitleCase(),
                      takePhotoText:
                          Languages.of(context)!.takePhotoLabel.toTitleCase(),
                      libraryText: Languages.of(context)!
                          .chooseFromLibraryLabel
                          .toTitleCase(),
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
                              iconColor: Theme.of(context).colorScheme.primary,
                              path: 'assets/icons/camera.png',
                              containerSize: 80,
                            ),
                          ),
                          SizedBox(
                            height: rSize(2),
                          ),
                          Text(
                            Languages.of(context)!
                                .addCoverPhotoLabel
                                .toTitleCase(),
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
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _imageFile != null
                        ? Container(
                            width: rSize(400),
                            height: rSize(225),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(rSize(10)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(_imageFile!),
                              ),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: settingsMgr
                                .profileManagement.profileMedia.coverURL!,
                            imageBuilder: (context, imageProvider) => Container(
                              width: rSize(400),
                              height: rSize(225),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(rSize(10))),
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
                                width: rSize(400),
                                height: rSize(225),
                                borderRadius: rSize(10),
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
                                  isCircleCropStyle: false,
                                  ratioX: 16,
                                  ratioY: 9,
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
                                .editCoverPhotoLabel
                                .toTitleCase(),
                            isPrimary: true,
                          ),
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        CustomButton(
                          customButtonProps: CustomButtonProps(
                            onTap: () => {deleteCoverPhoto()},
                            text: Languages.of(context)!
                                .deleteCoverPhotoLabel
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

    saveImage() async {
      if (_imageFile != null) {
        showLoaderDialog(context);
        File? imagePath = await compressImageNative(
          path: _imageFile!.absolute.path,
          quality: 80,
          targetWidth: 1000,
          targetHeight: (1000 * 9 / 16).round(),
        );
        settingsMgr.uploadCoverImage(imagePath!).then((value) => {
              Navigator.pop(context),
              showSuccessFlash(
                context: context,
                successColor: successPrimaryColor,
                successBody: Languages.of(context)!
                    .flashMessageSuccessTitle
                    .toTitleCase(),
                successTitle: Languages.of(context)!
                    .coverPhotoPhotoUploadedSuccessfullyBody
                    .toCapitalized(),
              ),
              setState(() {
                isSaveDisabled = true;
              })
            });
      }
    }

    return CustomContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: Languages.of(context)!.coverPhotoLabel.toTitleCase(),
            withBack: true,
            isTransparent: true,
            withSave: true,
            saveText: Languages.of(context)!.saveLabel,
            withSaveDisabled: isSaveDisabled,
            saveTap: () => {
              saveImage(),
            },
          ),
        ),
        body: Consumer<SettingsMgr>(
          builder: (context, settingsMgrMgr, _) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: rSize(30),
              vertical: rSize(40),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Languages.of(context)!.coverPhotoDescription.toCapitalized(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: rSize(80),
                ),
                renderBusinessCoverPhoto(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
