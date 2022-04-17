import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

showPickerTimeRangeModal(PickerTimeRangeModalProps pickerTimeRangeModalProps) {
  BuildContext context = pickerTimeRangeModalProps.context;
  Picker startTimePicker = Picker(
    backgroundColor: Theme.of(context).colorScheme.background,
    looping: false,
    textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
    hideHeader: true,
    adapter: DateTimePickerAdapter(
      type: PickerDateTimeType.kHM,
      minuteInterval: 5,
      minuteSuffix: 'm',
      hourSuffix: 'h',
      value: pickerTimeRangeModalProps.startTimeValue,
    ),
    onConfirm: (Picker picker, List value) {
      print((picker.adapter as DateTimePickerAdapter).value);
    },
  );

  Picker endTimePicker = Picker(
    containerColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    looping: false,
    hideHeader: true,
    textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
    adapter: DateTimePickerAdapter(
      type: PickerDateTimeType.kHM,
      minuteInterval: 5,
      minuteSuffix: 'm',
      hourSuffix: 'h',
      value: pickerTimeRangeModalProps.endTimeValue,
      minValue: pickerTimeRangeModalProps.endTimeMinValue,
    ),
    onSelect: (Picker picker, int int, List<int> list) => {
      print(picker),
      print(int),
      print(list),
    },
    onConfirm: (Picker picker, List value) {
      print((picker.adapter as DateTimePickerAdapter).value);
    },
  );
// ps.onConfirm(ps, ps.selecteds);
  List<Widget> actions = [
    TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('cancel'),
    ),
    TextButton(
      onPressed: () {
        Navigator.pop(context);
        // ps.onConfirm(ps, ps.selecteds);
        // pe.onConfirm(pe, pe.selecteds);
      },
      child: Text('Confirm'),
    )
  ];

  showBottomModal(
    BottomModalProps(
      title: 'Select Time',
      centerTitle: true,
      enableDrag: false,
      isDismissible: false,
      primaryButtonText: 'Save',
      secondaryButtonText: 'Cancel',
      footerButton: ModalFooter.both,
      showDragPen: false,
      primaryAction: pickerTimeRangeModalProps.primaryAction,
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            'Start Time',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: rSize(10),
          ),
          startTimePicker.makePicker(),
          SizedBox(
            height: rSize(10),
          ),
          Text(
            'End Time',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: rSize(10),
          ),
          endTimePicker.makePicker()
        ],
      ),
    ),
  );
}
