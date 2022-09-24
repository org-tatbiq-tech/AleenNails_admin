import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

showDurationPickerModal({
  required DurationPickerModalProps durationPickerModalProps,
}) {
  BuildContext context = durationPickerModalProps.context;
  Picker hoursPicker = Picker(
    backgroundColor: Theme.of(context).colorScheme.background,
    looping: durationPickerModalProps.looping,
    textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
    itemExtent: rSize(40),
    delimiter: [
      PickerDelimiter(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'hours',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    ],
    hideHeader: true,
    selecteds: [durationPickerModalProps.selectedHours],
    adapter: PickerDataAdapter(
      pickerdata: durationPickerModalProps.hoursData,
    ),
    onSelect: (Picker picker, int int, List<int> list) => {},
    onConfirm: (Picker picker, List value) {
      durationPickerModalProps.primaryAction != null
          ? durationPickerModalProps.primaryAction!((value))
          : () => {};
    },
  );
  Picker minutesPicker = Picker(
    backgroundColor: Theme.of(context).colorScheme.background,
    looping: durationPickerModalProps.looping,
    textStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
    itemExtent: rSize(40),
    delimiter: [
      PickerDelimiter(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'mins',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    ],
    hideHeader: true,
    selecteds: [durationPickerModalProps.selectedMinutes],
    adapter: PickerDataAdapter(
      pickerdata: durationPickerModalProps.minutesData,
    ),
    onSelect: (Picker picker, int int, List<int> list) => {},
    onConfirm: (Picker picker, List value) {
      durationPickerModalProps.primaryAction != null
          ? durationPickerModalProps.primaryAction!((value))
          : () => {};
    },
  );

  showBottomModal(
    bottomModalProps: BottomModalProps(
      context: context,
      title: durationPickerModalProps.title,
      centerTitle: true,
      enableDrag: false,
      isDismissible: false,
      primaryButtonText: durationPickerModalProps.primaryButtonText,
      secondaryButtonText: durationPickerModalProps.secondaryButtonText,
      footerButton: ModalFooter.both,
      showDragPen: false,
      primaryAction: () => {
        hoursPicker.onConfirm!(
          hoursPicker,
          hoursPicker.selecteds,
        )
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                hoursPicker.makePicker(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                minutesPicker.makePicker(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class DurationPickerModalProps {
  BuildContext context;
  String title;
  Function? primaryAction;
  bool looping;
  List<dynamic> hoursData;
  List<dynamic> minutesData;
  int selectedHours;
  int selectedMinutes;
  String primaryButtonText;
  String secondaryButtonText;

  DurationPickerModalProps({
    required this.context,
    this.title = '',
    required this.hoursData,
    required this.minutesData,
    this.looping = false,
    this.primaryAction,
    this.selectedHours = 0,
    this.selectedMinutes = 0,
    required this.primaryButtonText,
    required this.secondaryButtonText,
  });
}
