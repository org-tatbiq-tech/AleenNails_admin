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
    looping: true,
    textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
    itemExtent: rSize(40),
    hideHeader: true,
    adapter: PickerDataAdapter(
      pickerdata: wheelPickerModalProps.pickerData,
    ),
    onSelect: (Picker picker, int int, List<int> list) => {
      // print(getTimeFormat((picker.adapter as DateTimePickerAdapter).value)),
    },
    onConfirm: (Picker picker, List value) {
      wheelPickerModalProps.primaryAction != null
          ? wheelPickerModalProps
              .primaryAction!((picker.adapter as DateTimePickerAdapter).value)
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
