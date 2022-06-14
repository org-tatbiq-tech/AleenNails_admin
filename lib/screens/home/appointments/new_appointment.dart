import 'package:appointments/data_types/components.dart';
import 'package:appointments/screens/home/clients/clientSelection.dart';
import 'package:appointments/screens/home/services/services.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/input_validation.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/client_card.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_input_field_button.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:appointments/widget/picker_date_time_modal.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment({Key? key}) : super(key: key);

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  DateTime? startDateTime;
  DateTime? startDateTimeTemp;
  DateTime? endTime;
  DateTime? endTimeTemp;
  DateTime? endTimeMin;
  Client? selectedClient;
  Service? selectedService;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onServiceTap(Service service) {
    setState(() {
      selectedService = service;
    });
    Navigator.pop(context);
  }

  onClientTap(Client client) {
    setState(() {
      selectedClient = client;
    });
    Navigator.pop(context);
  }

  isButtonDisabled() {
    if (selectedService != null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Widget renderServicePicker() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: rSize(5),
              left: rSize(10),
              right: rSize(10),
            ),
            child: Text(
              'Service',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          CustomInputFieldButton(
            text: selectedService?.name ?? 'Choose Service',
            height: selectedService != null ? 70 : 50,
            textWidget: selectedService != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      VerticalDivider(
                        color: Theme.of(context).colorScheme.primary,
                        width: rSize(4),
                        endIndent: rSize(8),
                        thickness: rSize(3),
                        indent: rSize(8),
                      ),
                      SizedBox(
                        width: rSize(15),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              selectedService?.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Text(
                              selectedService?.duration.toString() ?? '',
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                      ),
                      Text(
                        getStringPrice(selectedService?.cost ?? 0),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        width: rSize(20),
                      ),
                    ],
                  )
                : null,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Services(
                  selectionMode: true,
                  onTap: (Service service) => onServiceTap(service),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget renderTimePicker() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: rSize(5),
                    left: rSize(10),
                    right: rSize(10),
                  ),
                  child: Text(
                    'Start Date & Time',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                CustomInputFieldButton(
                  text: getDateTimeFormat(
                    isDayOfWeek: true,
                    dateTime: startDateTime,
                    format: 'dd MMM yyyy • HH:mm',
                  ),
                  onTap: () => showPickerDateTimeModal(
                    pickerDateTimeModalProps: PickerDateTimeModalProps(
                      context: context,
                      minimumDate: DateTime.now(),
                      initialDateTime: startDateTime,
                      title: 'Start Date & Time',
                      onDateTimeChanged: (DateTime value) => {
                        setState(() {
                          startDateTimeTemp = value;
                        }),
                      },
                      primaryAction: () => {
                        setState(() {
                          startDateTime = startDateTimeTemp;
                          endTimeMin = startDateTimeTemp;
                        }),
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: rSize(20),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: rSize(5),
                    left: rSize(10),
                    right: rSize(10),
                  ),
                  child: Text('End',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2),
                ),
                CustomInputFieldButton(
                  text: getDateTimeFormat(
                    dateTime: endTime,
                    format: 'HH:mm',
                  ),
                  onTap: () => showPickerDateTimeModal(
                    pickerDateTimeModalProps: PickerDateTimeModalProps(
                      mode: CupertinoDatePickerMode.time,
                      context: context,
                      initialDateTime: endTime ?? endTimeMin,
                      minimumDate: endTimeMin,
                      title: 'End Time',
                      onDateTimeChanged: (DateTime value) => {
                        setState(() {
                          endTimeTemp = value;
                        }),
                      },
                      primaryAction: () => {
                        setState(() {
                          endTime = endTimeTemp;
                        }),
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    renderClient() {
      return selectedClient == null
          ? EaseInAnimation(
              beginAnimation: 0.99,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientSelection(
                    onTap: (Client client) => {onClientTap(client)},
                  ),
                ),
              ),
              child: DottedBorder(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                borderType: BorderType.RRect,
                dashPattern: [rSize(6), rSize(4)],
                strokeWidth: rSize(1),
                radius: Radius.circular(
                  rSize(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: rSize(20),
                    vertical: rSize(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAvatar(
                        customAvatarProps: CustomAvatarProps(
                          enable: false,
                          circleShape: true,
                        ),
                      ),
                      SizedBox(
                        width: rSize(15),
                      ),
                      Expanded(
                        child: Text(
                          'Select a client or leave empty for walk-in',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      IconTheme(
                        data: Theme.of(context).primaryIconTheme,
                        child: Icon(
                          Icons.chevron_right,
                          size: rSize(25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ClientCard(
              clientCardProps: ClientCardProps(
                withNavigation: false,
                withDelete: true,
                onCloseTap: () => {
                  setState(() {
                    selectedClient = null;
                  })
                },
                contactDetails: selectedClient!,
              ),
            );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'New Appointment',
          withBack: true,
          withClipPath: true,
          barHeight: 110,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: rSize(20),
                    ),
                    renderClient(),
                    SizedBox(
                      height: rSize(40),
                    ),
                    renderServicePicker(),
                    SizedBox(
                      height: rSize(40),
                    ),
                    renderTimePicker(),
                  ],
                ),
              ),
              CustomButton(
                customButtonProps: CustomButtonProps(
                  onTap: () => {
                    Navigator.pop(context),
                  },
                  text: 'Save',
                  isPrimary: true,
                  isDisabled: isButtonDisabled(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
