import 'dart:io';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_image_picker.dart';
import 'package:appointments/widget/custom_modal.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

showImagePickerModal({
  required ImagePickerModalProps imagePickerModalProps,
}) {
  BuildContext context = imagePickerModalProps.context;

  Future libraryClicked() async {
    Navigator.pop(context);
    File? file = await customImagePicker(
      customImagePickerProps: CustomImagePickerProps(
        isGallery: true,
        cropImage: imagePickerModalProps.cropImage,
        cropStyle: imagePickerModalProps.cropStyle,
        saveImage: imagePickerModalProps.saveImage,
        cropperTitle: imagePickerModalProps.cropperTitle,
      ),
    );
    return file;
  }

  Future cameraClicked() async {
    Navigator.pop(context);
    File? file = await customImagePicker(
      customImagePickerProps: CustomImagePickerProps(
        isGallery: false,
        cropImage: imagePickerModalProps.cropImage,
        cropStyle: imagePickerModalProps.cropStyle,
        saveImage: imagePickerModalProps.saveImage,
        cropperTitle: imagePickerModalProps.cropperTitle,
      ),
    );
    return file;
  }

  showBottomModal(
    bottomModalProps: BottomModalProps(
      context: context,
      enableDrag: true,
      showDragPen: true,
      isDismissible: true,
      footerButton: ModalFooter.none,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: rSize(15),
            ),
            CustomButton(
              customButtonProps: CustomButtonProps(
                onTap: () => {cameraClicked()},
                isPrimary: true,
                isSecondary: false,
                text: 'Take a Photo',
              ),
            ),
            SizedBox(
              height: rSize(15),
            ),
            CustomButton(
              customButtonProps: CustomButtonProps(
                onTap: () => {libraryClicked()},
                isPrimary: true,
                isSecondary: false,
                text: 'Choose From Library',
              ),
            ),
            SizedBox(
              height: rSize(15),
            ),
            CustomButton(
              customButtonProps: CustomButtonProps(
                onTap: () => {
                  Navigator.pop(context),
                },
                isPrimary: false,
                isSecondary: true,
                text: 'Cancel',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class ImagePickerModalProps {
  BuildContext context;
  String title;
  CropStyle cropStyle;
  bool cropImage;
  Function saveImage;
  String? cropperTitle;
  ImagePickerModalProps({
    required this.context,
    this.title = '',
    this.cropStyle = CropStyle.rectangle,
    this.cropImage = true,
    required this.saveImage,
    this.cropperTitle,
  });
}
