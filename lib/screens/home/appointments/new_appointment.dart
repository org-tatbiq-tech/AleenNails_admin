import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/screens/home/clients/clientSelection.dart';
import 'package:appointments/screens/home/services/services.dart';
import 'package:appointments/utils/formats.dart';
import 'package:appointments/widget/appointment_service_card.dart';
import 'package:appointments/widget/client_card.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/custom_slide_able.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NewAppointment extends StatefulWidget {
  const NewAppointment({Key? key}) : super(key: key);

  @override
  State<NewAppointment> createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  final TextEditingController _notesController = TextEditingController();

  DateTime? startDateTime;
  DateTime? startDateTimeTemp;
  DateTime? endTime;
  Client? selectedClient;
  List<AppointmentService> selectedServices = [];

  @override
  void initState() {
    super.initState();
    _notesController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _notesController.dispose();
  }

  onServiceTap(Service service) {
    AppointmentService appointmentService = AppointmentService(
      id: service.id,
      name: service.name,
      startTime: DateTime.now(),
      duration: service.duration,
      cost: service.cost,
      colorID: service.colorID,
    );
    setState(() {
      selectedServices.add(appointmentService);
      endTime = startDateTime?.add(getServicesDuration());
    });
    Navigator.pop(context);
  }

  removeService(AppointmentService service) {
    setState(() {
      selectedServices.removeWhere((item) => item == service);
      endTime = startDateTime?.add(getServicesDuration());
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

  bool validateAppointmentData() {
    if (selectedClient == null) {
      showErrorFlash(
        context: context,
        errorTitle: 'Error',
        errorBody: 'Please select client.',
      );
      return false;
    }
    if (selectedServices.isEmpty) {
      showErrorFlash(
        context: context,
        errorTitle: 'Error',
        errorBody: 'Please select at least one service.',
      );
      return false;
    }
    if (startDateTime == null) {
      showErrorFlash(
        context: context,
        errorTitle: 'Error',
        errorBody: 'Please select start date & time.',
      );
      return false;
    }
    return true;
  }

  Duration getServicesDuration() {
    Duration totalDuration = const Duration();
    for (AppointmentService service in selectedServices) {
      totalDuration += service.duration;
    }
    return totalDuration;
  }

  saveAppointment() {
    if (validateAppointmentData()) {
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      List<AppointmentService> appointmentServices = [];

      for (var service in selectedServices) {
        AppointmentService appointmentService = AppointmentService(
          id: service.id,
          name: service.name,
          startTime: startDateTime!,
          duration: service.duration,
          cost: service.cost,
          colorID: service.colorID,
        );
        appointmentServices.add(appointmentService);
      }

      Appointment newAppointment = Appointment(
        id: '',
        clientName: selectedClient!.fullName,
        clientDocID: selectedClient!.id,
        clientPhone: selectedClient!.phone,
        creationDate: DateTime.now(),
        creator: 'Business',
        date: startDateTime!,
        paymentStatus: PaymentStatus.unpaid,
        services: selectedServices,
        status: AppointmentStatus.waiting,
        notes: _notesController.text,
      );

      appointmentsMgr.submitNewAppointment(newAppointment);
      showSuccessFlash(
        context: context,
        successTitle: 'Submitted!',
        successBody: 'Appointment was uploaded to DB successfully!',
      );
      Navigator.pop(context);
    }
  }

  renderServices() {
    List<Widget> widgetList =
        selectedServices.map((AppointmentService service) {
      return CustomSlidable(
        customSlidableProps: CustomSlidableProps(
          groupTag: 'newAppointment',
          deleteAction: () => removeService(service),
          child: AppointmentServiceCard(
            // key: ValueKey(service.id),
            appointmentServiceCardProps: AppointmentServiceCardProps(
              withNavigation: false,
              enabled: false,
              serviceDetails: service,
              title: service.name,
              subTitle: durationToFormat(duration: service.duration),
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
                          endTime = startDateTime?.add(getServicesDuration());
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
                  isDisabled: true,
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
                  controller: _notesController,
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
