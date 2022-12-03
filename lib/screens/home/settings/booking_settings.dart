import 'package:appointments/localization/language/languages.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/wheel_picker_modal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookingsSettings extends StatefulWidget {
  const BookingsSettings({Key? key}) : super(key: key);

  @override
  State<BookingsSettings> createState() => _BookingsSettingsState();
}

class _BookingsSettingsState extends State<BookingsSettings> {
  bool isEnabled = true;

  int selectedBookingWindowPicker = 0;
  int selectedFutureBookingPickerData = 0;
  int selectedReschedulingPickerData = 0;

  @override
  Widget build(BuildContext context) {
    List<String> bookingWindowPickerData = [
      Languages.of(context)!.notLessThan15Mins,
      Languages.of(context)!.notLessThan30Mins,
      Languages.of(context)!.notLessThan1H,
      Languages.of(context)!.notLessThan2H,
      Languages.of(context)!.notLessThan3H,
      Languages.of(context)!.notLessThan6H,
      Languages.of(context)!.notLessThan12H,
      Languages.of(context)!.notLessThan1D,
      Languages.of(context)!.notLessThan2D,
      Languages.of(context)!.notLessThan3D,
      Languages.of(context)!.notLessThan5D,
    ];

    List<String> futureBookingPickerData = [
      Languages.of(context)!.upTo7Days,
      Languages.of(context)!.upTo14Days,
      Languages.of(context)!.upTo1Month,
      Languages.of(context)!.upTo2Months,
      Languages.of(context)!.upTo3Months,
      Languages.of(context)!.upTo3Months,
      Languages.of(context)!.upTo6Months,
    ];

    List<String> reschedulingPickerData = [
      Languages.of(context)!.notBefore1Hour,
      Languages.of(context)!.notBefore2Hours,
      Languages.of(context)!.notBefore3Hours,
      Languages.of(context)!.notBefore6Hours,
      Languages.of(context)!.notBefore12Hours,
      Languages.of(context)!.notBefore1Day,
      Languages.of(context)!.notBefore2Days,
      Languages.of(context)!.notBefore3Days,
      Languages.of(context)!.notBefore5Days,
      Languages.of(context)!.notBefore7Days,
    ];

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
                Languages.of(context)!.labelAutomaticallyConfirm,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.labelAutomaticallyConfirmMsg,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.labelAutomaticallyConfirmMsgCompletion,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                Languages.of(context)!.labelBookingInAdvanceTitle,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.labelBookingInAdvanceExplanation,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                Languages.of(context)!.labelFutureBooking,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.labelFutureBookingExplanation,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                Languages.of(context)!.labelReschedulingWindow,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.labelReschedulingExplanation,
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
            Languages.of(context)!.labelRules,
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
              Languages.of(context)!.labelBookingInAdvanceTitle,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          CustomInputFieldButton(
            text: bookingWindowPickerData[selectedBookingWindowPicker],
            fontSize: 16,
            onTap: () => {
              showWheelPickerModal(
                wheelPickerModalProps: WheelPickerModalProps(
                  context: context,
                  pickerData: bookingWindowPickerData,
                  title: Languages.of(context)!.labelBookingInAdvanceModal,
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
              Languages.of(context)!.labelFutureBooking,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          CustomInputFieldButton(
            fontSize: 16,
            text: futureBookingPickerData[selectedFutureBookingPickerData],
            onTap: () => {
              showWheelPickerModal(
                wheelPickerModalProps: WheelPickerModalProps(
                  context: context,
                  pickerData: futureBookingPickerData,
                  title: Languages.of(context)!.labelFutureBookingModal,
                  selected: selectedFutureBookingPickerData,
                  primaryAction: (value) => {
                    setState(() {
                      selectedFutureBookingPickerData = value[0];
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
              Languages.of(context)!.labelReschedulingWindow,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          CustomInputFieldButton(
            fontSize: 16,
            text: reschedulingPickerData[selectedReschedulingPickerData],
            onTap: () => {
              showWheelPickerModal(
                wheelPickerModalProps: WheelPickerModalProps(
                  context: context,
                  pickerData: reschedulingPickerData,
                  title: Languages.of(context)!.labelReschedulingWindowModal,
                  selected: selectedReschedulingPickerData,
                  primaryAction: (value) => {
                    setState(() {
                      selectedReschedulingPickerData = value[0];
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
                    Languages.of(context)!.labelAutomaticallyConfirm,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: rSize(10),
                  ),
                  Text(
                    Languages.of(context)!.labelAutomaticallyConfirmMsg,
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
                isEnabled
                    ? Languages.of(context)!.enabledLabel
                    : Languages.of(context)!.disabledLabel,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: rSize(12),
                    ),
              ),
            ],
          ),
        ],
      );
    }

    return CustomContainer(
      imagePath: 'assets/images/background4.png',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: Languages.of(context)!.labelBookingRules,
            withBack: true,
            isTransparent: true,
            customIconTap: () => {
              getSettingInfo(),
            },
            customIcon: Icon(
              FontAwesomeIcons.circleQuestion,
              size: rSize(25),
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          right: false,
          left: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: rSize(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: rSize(30),
                ),
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
                          text: Languages.of(context)!.backLabel,
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
                          text: Languages.of(context)!.saveLabel,
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
      ),
    );
  }
}
