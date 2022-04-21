import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_image_picker.dart';
import 'package:appointments/widget/custom_modal.dart';
import 'package:flutter/material.dart';

showImagePickerModal({
  required ImagePickerModalProps imagePickerModalProps,
}) {
  BuildContext context = imagePickerModalProps.context;

  Future _libraryClicked() async {
    Navigator.pop(context);
    final file = await CustomImagePicker(
      customImagePickerProps: CustomImagePickerProps(
        isGallery: true,
        cropImage: true,
      ),
    );
  }

  Future _cameraClicked() async {
    Navigator.pop(context);
    final file = await CustomImagePicker(
      customImagePickerProps: CustomImagePickerProps(
        isGallery: false,
        cropImage: true,
      ),
    );
  }

  showBottomModal(
    bottomModalProps: BottomModalProps(
      // title: '',
      context: context,
      // centerTitle: true,
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
                onTap: () => {_cameraClicked()},
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
                onTap: () => {_libraryClicked()},
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
