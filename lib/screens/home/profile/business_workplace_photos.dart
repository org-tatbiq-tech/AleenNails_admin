import 'dart:io';

import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/utils/layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_gallery.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
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
import 'package:uuid/uuid.dart';

class BusinessWorkplacePhotos extends StatefulWidget {
  const BusinessWorkplacePhotos({Key? key}) : super(key: key);

  @override
  State<BusinessWorkplacePhotos> createState() =>
      _BusinessWorkplacePhotosState();
}

class _BusinessWorkplacePhotosState extends State<BusinessWorkplacePhotos> {
  bool disposed = false;
  // Map<String, File> mediaList = {};
  Map<String, File> mediaListToUpload = {};
  bool _isLoading = false;

  List<GalleryItem> mediaList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    uploadedSuccessfully() {
      showSuccessFlash(
        context: context,
        successColor: successPrimaryColor,
        successTitle:
            Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
        successBody: Languages.of(context)!
            .wpPhotoUploadedSuccessfullyBody
            .toCapitalized(),
      );
      Navigator.pop(context);
      setState(() {
        mediaListToUpload = {};
      });
    }

    getResizedMediaToUpload() async {
      Map<String, File> resizedMediaListToUpload = {};
      for (var element in mediaListToUpload.entries) {
        resizedMediaListToUpload[element.key] =
            (await compressImageNative(path: element.value.absolute.path))!;
      }
      return resizedMediaListToUpload;
    }

    uploadWorkplacePhotos() async {
      final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
      if (mediaListToUpload.isNotEmpty) {
        showLoaderDialog(context);
        Map<String, File> resizedMediaListToUpload =
            await getResizedMediaToUpload();
        await settingsMgr.uploadWPImages(resizedMediaListToUpload);
        uploadedSuccessfully();
      }
    }

    deleteWorkspacePhoto(String url) async {
      final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
      await settingsMgr.deleteWPImage(url);
    }

    removeWorkspacePhoto({required String imageKey, bool isUrl = true}) {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.deleteLabel.toTitleCase(),
          secondaryButtonText: Languages.of(context)!.cancelLabel.toTitleCase(),
          deleteCancelModal: true,
          primaryAction: () async => {
            showLoaderDialog(context),
            if (isUrl)
              {await deleteWorkspacePhoto(imageKey), setState(() {})}
            else
              {
                setState(() {
                  mediaListToUpload
                      .removeWhere((key, value) => key == imageKey);
                })
              },
            Navigator.pop(context),
            showSuccessFlash(
              context: context,
              successColor: successPrimaryColor,
              successBody:
                  Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
              successTitle: Languages.of(context)!
                  .wpPhotoDeletedSuccessfullyBody
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
                '${Languages.of(context)!.deletePhotoLabel.toTitleCase()}?',
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

    List<Widget> mediaCards() {
      List<Widget> widgetList = [];
      final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
      for (var workspacePhoto in settingsMgr
          .profileManagement.profileMedia.wpPhotosURLsMap!.entries) {
        widgetList.add(
          EaseInAnimation(
            beginAnimation: 0.98,
            onTap: () => {
              removeWorkspacePhoto(imageKey: workspacePhoto.key),
            },
            child: Container(
              width: rSize(100),
              height: rSize(100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(rSize(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      workspacePhoto.value,
                    ),
                  )),
            ),
          ),
        );
      }
      for (var workspacePhoto in mediaListToUpload.entries) {
        widgetList.add(
          EaseInAnimation(
            beginAnimation: 0.98,
            onTap: () => {
              removeWorkspacePhoto(imageKey: workspacePhoto.key, isUrl: false),
            },
            child: Container(
              width: rSize(100),
              height: rSize(100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(rSize(10)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(
                    workspacePhoto.value,
                  ),
                ),
              ),
            ),
          ),
        );
      }
      widgetList.insert(
        0,
        EaseInAnimation(
          onTap: () => {
            showImagePickerModal(
                imagePickerModalProps: ImagePickerModalProps(
              context: context,
              cancelText: Languages.of(context)!.cancelLabel.toTitleCase(),
              deleteText: Languages.of(context)!.deleteLabel.toTitleCase(),
              takePhotoText:
                  Languages.of(context)!.takePhotoLabel.toTitleCase(),
              libraryText:
                  Languages.of(context)!.chooseFromLibraryLabel.toTitleCase(),
              saveImage: (File imageFile) {
                setState(() {
                  var uid = const Uuid().v4();
                  mediaListToUpload[uid] = imageFile;
                });
              },
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
                      iconColor: Theme.of(context).colorScheme.primary,
                      containerSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: rSize(2),
                  ),
                  Text(
                    Languages.of(context)!.addMediaLabel.toTitleCase(),
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
          titleText: Languages.of(context)!.workplacePhotoLabel.toTitleCase(),
          withBack: true,
          barHeight: 110,
          withClipPath: true,
          withSave: true,
          saveText: Languages.of(context)!.saveLabel,
          withSaveDisabled: mediaListToUpload.isEmpty,
          saveTap: () => {
            uploadWorkplacePhotos(),
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
              Languages.of(context)!.workplacePhotoDescription.toCapitalized(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: rSize(40),
            ),
            _isLoading
                ? CustomLoadingIndicator(
                    customLoadingIndicatorProps: CustomLoadingIndicatorProps(),
                  )
                : renderMedia(),
          ],
        ),
      ),
    );
  }
}
