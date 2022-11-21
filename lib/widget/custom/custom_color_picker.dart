import 'package:appointments/localization/language/languages.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void showColorPicker({
  required ColorPickerProps colorPickerProps,
}) {
  showBottomModal(
    bottomModalProps: BottomModalProps(
      context: colorPickerProps.context,
      title: 'Choose Your Color',
      centerTitle: true,
      isDismissible: false,
      footerButton: ModalFooter.both,
      primaryButtonText: Languages.of(colorPickerProps.context)!.saveLabel,
      secondaryButtonText: Languages.of(colorPickerProps.context)!.cancelLabel,
      primaryAction: colorPickerProps.primaryAction,
      child: ColorPicker(
        displayThumbColor: true,
        hexInputBar: false,
        pickerAreaBorderRadius: BorderRadius.circular(rSize(10)),
        pickerAreaHeightPercent: 1,
        pickerColor: colorPickerProps.pickerColor,
        onColorChanged: colorPickerProps.onColorChanged,
        enableAlpha: colorPickerProps.enableAlpha,
        labelTypes: colorPickerProps.labelTypes,
      ),
    ),
  );
}

class ColorPickerProps {
  BuildContext context;
  Color pickerColor;
  Function(Color) onColorChanged;
  Function primaryAction;
  bool enableAlpha;
  List<ColorLabelType> labelTypes;

  ColorPickerProps({
    required this.context,
    required this.pickerColor,
    required this.onColorChanged,
    required this.primaryAction,
    this.enableAlpha = false,
    this.labelTypes = const [],
  });
}
