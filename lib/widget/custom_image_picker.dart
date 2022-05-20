import 'dart:io';

import 'package:appointments/utils/data_types.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<File?> CustomImagePicker({
  required CustomImagePickerProps customImagePickerProps,
}) async {
  _permissionStatus();
  final source = customImagePickerProps.isGallery
      ? ImageSource.gallery
      : ImageSource.camera;
  final pickedFile = await ImagePicker().pickImage(source: source);

  if (pickedFile == null) return null;
  if (!customImagePickerProps.cropImage) {
    return File(pickedFile.path);
  } else {
    final file = File(pickedFile.path);
    _cropImage(file, customImagePickerProps);
  }
  return null;
}

Future<CroppedFile?> _cropImage(
        File imageFile, CustomImagePickerProps customImagePickerProps) async =>
    await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.original],
      compressQuality: 70,
      compressFormat: ImageCompressFormat.png,
      cropStyle: customImagePickerProps.cropStyle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: customImagePickerProps.cropperTitle ?? 'Cropper Title',
        ),
        IOSUiSettings(
          title: customImagePickerProps.cropperTitle,
          cancelButtonTitle: 'Cancel',
          doneButtonTitle: 'Done',
        ),
      ],
    );

_permissionStatus() async {
  PermissionStatus status = await Permission.camera.status;
  if (status.isPermanentlyDenied) return openAppSettings();
  status = await Permission.camera.request();
  if (status.isDenied) return;
}
