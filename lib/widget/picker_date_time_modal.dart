import 'package:appointments/data_types/macros.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/custom_modal.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showPickerDateTimeModal({
  required PickerDateTimeModalProps pickerDateTimeModalProps,
}) {
  BuildContext context = pickerDateTimeModalProps.context;
  showBottomModal(
    bottomModalProps: BottomModalProps(
      title: pickerDateTimeModalProps.title,
      centerTitle: true,
      enableDrag: false,
      isDismissible: false,
      primaryButtonText: 'Save',
      secondaryButtonText: 'Cancel',
      footerButton: ModalFooter.both,
      showDragPen: false,
      primaryAction: pickerDateTimeModalProps.primaryAction,
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: pickerDateTimeModalProps.height ?? rSize(200),
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle:
                      Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                ),
              ),
              child: CupertinoDatePicker(
                mode: pickerDateTimeModalProps.mode,
                use24hFormat: pickerDateTimeModalProps.use24hFormat,
                minuteInterval: pickerDateTimeModalProps.minuteInterval,
                onDateTimeChanged: (value) =>
                    pickerDateTimeModalProps.onDateTimeChanged(value),
                initialDateTime:
                    pickerDateTimeModalProps.initialDateTime ?? DateTime.now(),
                minimumDate: pickerDateTimeModalProps.minimumDate,
                maximumDate: pickerDateTimeModalProps.maximumDate,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class PickerDateTimeModalProps {
  BuildContext context;
  String title;
  double? height;
  bool use24hFormat;
  Function onDateTimeChanged;
  Function? primaryAction;
  DateTime? initialDateTime;
  DateTime? minimumDate;
  DateTime? maximumDate;
  int minuteInterval;
  CupertinoDatePickerMode mode;

  PickerDateTimeModalProps({
    required this.context,
    this.title = '',
    this.height,
    this.use24hFormat = true,
    required this.onDateTimeChanged,
    this.primaryAction,
    this.initialDateTime,
    this.minimumDate,
    this.maximumDate,
    this.minuteInterval = 1,
    this.mode = CupertinoDatePickerMode.dateAndTime,
  });
}
