import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:appointments/providers/app_data.dart';
import 'package:appointments/screens/home/clients/clientSelection.dart';
import 'package:appointments/screens/home/services/services.dart';
import 'package:appointments/widget/custom_slide_able.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:appointments/widget/service_card.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:appointments/widget/client_card.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment({Key? key}) : super(key: key);

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? startDateTime;
  DateTime? startDateTimeTemp;
  DateTime? endTime;
  DateTime? endTimeTemp;
  DateTime? endTimeMin;
  Client? selectedClient;
  List<Service> selectedServices = [];

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  onServiceTap(Service service) {
    setState(() {
      selectedServices.add(service);
    });
    Navigator.pop(context);
  }

  removeService(Service service) {
    setState(() {
      selectedServices.removeWhere((item) => item == service);
    });
  }

  onClientTap(Client client) {
    setState(() {
      selectedClient = client;
    });
    Navigator.pop(context);
  }

  isButtonDisabled() {
    if (selectedServices != null) {
      return false;
    }
    return true;
  }

  saveAppointment() {
    /// need to add validation
    final appData = Provider.of<AppData>(context, listen: false);
    List<AppointmentService> appointmentServices = [];

    selectedServices.forEach((element) {
      AppointmentService appointmentService = AppointmentService(
        element.id,
        element.name,
        startDateTime!,
        (startDateTime!).add(element.duration),
        element.duration,
        element.cost,
        element.colorID,
      );
      appointmentServices.add(appointmentService);
    });

    Appointment newAppointment = Appointment(
      'id',
      Status.waiting,
      (FirebaseAuth.instance.currentUser?.displayName).toString(),
      (selectedClient?.name).toString(),
      (selectedClient?.phone).toString(),
      (selectedClient?.id).toString(),
      DateTime.now(),
      startDateTime!,
      '',
      appointmentServices,
    );
    appData.submitNewAppointment(newAppointment);
    Navigator.pop(context);
  }

  renderServices() {
    List<Widget> widgetList = selectedServices.map((Service service) {
      return CustomSlidable(
        customSlidableProps: CustomSlidableProps(
          groupTag: 'newAppointment',
          deleteAction: () => removeService(service),
          child: ServiceCard(
            // key: ValueKey(service.id),
            serviceCardProps: ServiceCardProps(
              withNavigation: false,
              enabled: false,
              serviceDetails: service,
              title: service.name,
              subTitle: service.duration.toString(),
            ),
          ),
        ),
      );
    }).toList();

    return widgetList;
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
              bottom: rSize(10),
              left: rSize(10),
              right: rSize(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Services',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                selectedServices.isNotEmpty
                    ? CustomTextButton(
                        customTextButtonProps: CustomTextButtonProps(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Services(
                                      selectionMode: true,
                                      onTap: (Service service) =>
                                          onServiceTap(service),
                                    ),
                                  ),
                                ),
                            text: 'Add Service',
                            fontSize: rSize(14),
                            textColor: darken(
                              Theme.of(context).colorScheme.secondary,
                              0.2,
                            ),
                            withIcon: true,
                            icon: Icon(
                              FontAwesomeIcons.plus,
                              color: darken(
                                Theme.of(context).colorScheme.secondary,
                                0.2,
                              ),
                              size: rSize(14),
                            )),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          selectedServices.isEmpty
              ? CustomInputFieldButton(
                  text: 'Choose Service',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Services(
                        selectionMode: true,
                        onTap: (Service service) => onServiceTap(service),
                      ),
                    ),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: renderServices(),
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

    Widget renderNote() {
      return Padding(
        padding: EdgeInsets.only(
          top: rSize(40),
        ),
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
                'Notes',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(
              height: rSize(120),
              child: CustomInputField(
                customInputFieldProps: CustomInputFieldProps(
                  controller: _descriptionController,
                  // hintText:
                  //     'Short description of your business working hours (recommended)',
                  isDescription: true,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: 'New Appointment',
            withBack: true,
            withClipPath: true,
            barHeight: 110,
            withSave: true,
            saveTap: () => {saveAppointment()},
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          top: false,
          left: false,
          right: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: rSize(30),
                    vertical: rSize(20),
                  ),
                  child: Column(
                    children: [
                      renderClient(),
                      SizedBox(
                        height: rSize(40),
                      ),
                      renderServicePicker(),
                      SizedBox(
                        height: rSize(40),
                      ),
                      renderTimePicker(),
                      renderNote(),
                      // SizedBox(
                      //   height: rSize(40),
                      // ),
                      // CustomButton(
                      //   customButtonProps: CustomButtonProps(
                      //     onTap: () => {saveAppointment()},
                      //     text: 'Save',
                      //     isPrimary: true,
                      //     isDisabled: isButtonDisabled(),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
