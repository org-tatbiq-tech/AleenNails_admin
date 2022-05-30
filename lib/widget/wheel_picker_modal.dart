import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

showWheelPickerModal({
  required WheelPickerModalProps wheelPickerModalProps,
}) {
  BuildContext context = wheelPickerModalProps.context;
  Picker wheelPicker = Picker(
    backgroundColor: Theme.of(context).colorScheme.background,
    looping: wheelPickerModalProps.looping,
    textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
    itemExtent: rSize(40),
    hideHeader: true,
    selecteds: [wheelPickerModalProps.selected],
    adapter: PickerDataAdapter(
      pickerdata: wheelPickerModalProps.pickerData,
    ),
    onSelect: (Picker picker, int int, List<int> list) => {},
    onConfirm: (Picker picker, List value) {
      wheelPickerModalProps.primaryAction != null
          ? wheelPickerModalProps.primaryAction!((value))
          : () => {};
    },
  );

  showBottomModal(
    bottomModalProps: BottomModalProps(
      title: wheelPickerModalProps.title,
      centerTitle: true,
      enableDrag: false,
      isDismissible: false,
      primaryButtonText: 'Save',
      secondaryButtonText: 'Cancel',
      footerButton: ModalFooter.both,
      showDragPen: false,
      primaryAction: () => {
        wheelPicker.onConfirm!(
          wheelPicker,
          wheelPicker.selecteds,
        )
      },
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          wheelPicker.makePicker(),
        ],
      ),
    ),
  );
}

class WheelPickerModalProps {
  BuildContext context;
  String title;
  Function? primaryAction;
  bool looping;
  List<dynamic> pickerData;
  int selected;

  WheelPickerModalProps({
    required this.context,
    this.title = '',
    required this.pickerData,
    this.looping = false,
    this.primaryAction,
    this.selected = 0,
  });
}
