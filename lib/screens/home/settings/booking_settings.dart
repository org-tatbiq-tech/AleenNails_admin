import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_input_field_button.dart';
import 'package:appointments/widget/custom_modal.dart';
import 'package:appointments/widget/wheel_picker_modal.dart';
import 'package:flutter/material.dart';

class BookingsSettings extends StatefulWidget {
  const BookingsSettings({Key? key}) : super(key: key);

  @override
  State<BookingsSettings> createState() => _BookingsSettingsState();
}

class _BookingsSettingsState extends State<BookingsSettings> {
  bool isEnabled = false;

  int selectedBookingWindowPicker = 0;
  int selectedFutureBookingPickerdata = 0;
  int selectedReschedulingPickerdata = 0;

  List<String> bookingWindowPickerdata = [
    'No less than 15 minutes in advance',
    'No less than 30 minutes in advance',
    'No less than 1 hour in advance',
    'No less than 2 hours in advance',
    'No less than 3 hours in advance',
    'No less than 6 hours in advance',
    'No less than 12 hours in advance',
    'No less than 1 day in advance',
    'No less than 2 days in advance',
    'No less than 3 days in advance',
    'No less than 5 days in advance',
  ];
  List<String> futureBookingPickerdata = [
    'Up to 7 days in the future',
    'Up to 14 days in the future',
    'Up to 1 month in the future',
    'Up to 2 months in the future',
    'Up to 3 months in the future',
    'Up to 6 months in the future',
    'Up to 12 months in the future',
    'Up to 24 months in the future',
  ];
  List<String> reschedulingPickerdata = [
    'No less than 1 hour in advance',
    'No less than 2 hours in advance',
    'No less than 3 hours in advance',
    'No less than 6 hours in advance',
    'No less than 12 hours in advance',
    'No less than 1 day in advance',
    'No less than 2 days in advance',
    'No less than 3 days in advance',
    'No less than 5 days in advance',
    'No less than 7 days in advance',
  ];
  @override
  Widget build(BuildContext context) {
    getSettingInfo() {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          enableDrag: true,
          showDragPen: true,
          footerButton: ModalFooter.none,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'Automatic Confirmation',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'When this is turned on Application will automatically confirm bookings for you. This is easier for you, and your clients.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'If this option is turned off you will have to manually confirm each customer booking. Please note: Your availability is only updated upon confirmation, not based in requests. this means you could receive multiple customer request for the same time slot.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                'Booking window',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'How mch of a window do you need between the time of booking and the appointment time? This helps you to plan ahead and eliminates any surprises appointments.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                'Future Booking window',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'Choose how far in the future clients can schedule appointments if you want to encourage repeat bookings we recommend setting this for a longer time period.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                'Rescheduling',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'Choose how long before an appointment a client can reschedule or cancel.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      );
    }

    Widget renderBookingRules() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Booking Rules',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: rSize(20),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: rSize(5),
              left: rSize(10),
              right: rSize(10),
            ),
            child: Text(
              'Booking Window',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          CustomInputFieldButton(
            text: bookingWindowPickerdata[selectedBookingWindowPicker],
            fontSize: 16,
            onTap: () => {
              showWheelPickerModal(
                wheelPickerModalProps: WheelPickerModalProps(
                  context: context,
                  pickerData: bookingWindowPickerdata,
                  title: 'Booking Window',
                  selected: selectedBookingWindowPicker,
                  primaryAction: (value) => {
                    setState(() {
                      selectedBookingWindowPicker = value[0];
                    })
                  },
                ),
              )
            },
          ),
          SizedBox(
            height: rSize(20),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: rSize(5),
              left: rSize(10),
              right: rSize(10),
            ),
            child: Text(
              'Future Booking Window',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          CustomInputFieldButton(
            fontSize: 16,
            text: futureBookingPickerdata[selectedFutureBookingPickerdata],
            onTap: () => {
              showWheelPickerModal(
                wheelPickerModalProps: WheelPickerModalProps(
                  context: context,
                  pickerData: futureBookingPickerdata,
                  title: 'Future Booking Window',
                  selected: selectedFutureBookingPickerdata,
                  primaryAction: (value) => {
                    setState(() {
                      selectedFutureBookingPickerdata = value[0];
                    })
                  },
                ),
              )
            },
          ),
          SizedBox(
            height: rSize(20),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: rSize(5),
              left: rSize(10),
              right: rSize(10),
            ),
            child: Text(
              'Rescheduling',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          CustomInputFieldButton(
            fontSize: 16,
            text: reschedulingPickerdata[selectedReschedulingPickerdata],
            onTap: () => {
              showWheelPickerModal(
                wheelPickerModalProps: WheelPickerModalProps(
                  context: context,
                  pickerData: reschedulingPickerdata,
                  title: 'Rescheduling',
                  selected: selectedReschedulingPickerdata,
                  primaryAction: (value) => {
                    setState(() {
                      selectedReschedulingPickerdata = value[0];
                    })
                  },
                ),
              )
            },
          ),
        ],
      );
    }

    Widget renderSwitch() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: rSize(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Automatically confirm bookings',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: rSize(10),
                  ),
                  Text(
                    'When you turn on automatic confirmations, you save time and make it easier for your clients to book. we recommends it.',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: rSize(20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: rSize(70),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    splashRadius: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    inactiveTrackColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    inactiveThumbColor:
                        Theme.of(context).colorScheme.background,
                    value: isEnabled,
                    onChanged: (bool state) {
                      setState(() {
                        isEnabled = state;
                      });
                    },
                  ),
                ),
              ),
              Text(
                isEnabled ? 'Enabled' : 'Disabled',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: rSize(12),
                    ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
            titleText: 'Booking Settings',
            withBack: true,
            barHeight: 110,
            withClipPath: true,
            customIconTap: () => {getSettingInfo()},
            customIcon: CustomIcon(
              customIconProps: CustomIconProps(
                icon: null,
                path: 'assets/icons/question.png',
                contentPadding: rSize(8),
                withPadding: true,
              ),
            )),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        top: false,
        right: false,
        left: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
            // vertical: rSize(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: rSize(10),
                  ),
                  renderSwitch(),
                  SizedBox(
                    height: rSize(40),
                  ),
                  renderBookingRules(),
                ],
              )),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      customButtonProps: CustomButtonProps(
                        text: 'Reset',
                        isPrimary: false,
                        isSecondary: true,
                        onTap: (() => Navigator.pop(context)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: rSize(20),
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      customButtonProps: CustomButtonProps(
                        text: 'Save',
                        onTap: (() => Navigator.pop(context)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
