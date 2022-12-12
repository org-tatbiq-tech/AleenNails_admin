import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/screens/home/clients/clientSelection.dart';
import 'package:appointments/screens/home/services/services.dart';
import 'package:appointments/utils/general.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/appointment/appointment_service_card.dart';
import 'package:appointments/widget/client/client_card.dart';
import 'package:appointments/widget/custom/custom_slide_able.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_avatar.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_text_button.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatefulWidget {
  final Client? client;
  final Appointment? appointment;
  final Appointment? bookAgainAppointment;
  const AppointmentScreen(
      {Key? key, this.client, this.appointment, this.bookAgainAppointment})
      : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final TextEditingController _notesController = TextEditingController();

  DateTime startDateTime = nearestRange(DateTime.now());
  DateTime startDateTimeTemp = nearestRange(DateTime.now());
  DateTime? endTime;
  Client? selectedClient;
  List<AppointmentService> selectedServices = [];
  Appointment? appointment;

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      selectedClient = widget.client;
    }
    if (widget.appointment != null) {
      appointment = Appointment.fromAppointment(widget.appointment!);

      selectedClient = Client(
        id: appointment!.clientDocID,
        fullName: appointment!.clientName,
        phone: appointment!.clientPhone,
        address: '',
        email: appointment!.clientEmail,
        imageURL: appointment!.clientImageURL,
        creationDate: DateTime.now(),
      );
      selectedServices = appointment!.services;
      startDateTime = appointment!.date;
      startDateTimeTemp = appointment!.date;
      endTime = appointment!.endTime;
      _notesController.text = appointment!.notes;
    }
    if (widget.bookAgainAppointment != null) {
      selectedClient = Client(
        id: widget.bookAgainAppointment!.clientDocID,
        fullName: widget.bookAgainAppointment!.clientName,
        phone: widget.bookAgainAppointment!.clientPhone,
        address: '',
        email: appointment!.clientEmail,
        imageURL: widget.bookAgainAppointment!.clientImageURL,
        creationDate: DateTime.now(),
      );
      selectedServices = widget.bookAgainAppointment!.services;
      _notesController.text = widget.bookAgainAppointment!.notes;
      endTime = startDateTime.add(getServicesDuration());
    }
    _notesController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _notesController.dispose();
  }

  DateTime getMinDate() {
    if (nearestRange(DateTime.now()).isAfter(startDateTime)) {
      return startDateTime;
    }
    return nearestRange(DateTime.now());
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
      endTime = startDateTime.add(getServicesDuration());
    });
    Navigator.pop(context);
  }

  removeService(AppointmentService service) {
    setState(() {
      selectedServices.removeWhere((item) => item == service);
      endTime = startDateTime.add(getServicesDuration());
    });
  }

  onClientTap(Client client) {
    setState(() {
      selectedClient = client;
    });
    Navigator.pop(context);
  }

  bool validateAppointmentData() {
    if (selectedClient == null) {
      showErrorFlash(
        context: context,
        errorTitle: Languages.of(context)!.flashMessageErrorTitle.toTitleCase(),
        errorBody: Languages.of(context)!.clientMissingBody.toCapitalized(),
        errorColor: errorPrimaryColor,
      );
      return false;
    }
    if (selectedServices.isEmpty) {
      showErrorFlash(
        context: context,
        errorTitle: Languages.of(context)!.flashMessageErrorTitle.toTitleCase(),
        errorBody: Languages.of(context)!.serviceMissingBody.toTitleCase(),
        errorColor: errorPrimaryColor,
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

  saveAppointment() async {
    if (validateAppointmentData()) {
      showLoaderDialog(context);
      final appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);

      // update services start time
      List<AppointmentService> updatedServices = [];
      bool first = true;
      AppointmentService? lastApp;
      for (AppointmentService appointmentService in selectedServices) {
        DateTime startTime;
        if (first) {
          first = false;
          startTime = DateTime(
            startDateTime.year,
            startDateTime.month,
            startDateTime.day,
            startDateTime.hour,
            startDateTime.minute,
          );
        } else {
          startTime = lastApp!.endTime;
        }
        AppointmentService currAppointmentService = AppointmentService(
          id: appointmentService.id,
          name: appointmentService.name,
          startTime: startTime,
          duration: appointmentService.duration,
          cost: appointmentService.cost,
          colorID: appointmentService.colorID,
        );
        updatedServices.add(currAppointmentService);
        lastApp = currAppointmentService;
      }

      // for (var service in selectedServices) {
      //   AppointmentService appointmentService = AppointmentService(
      //     id: service.id,
      //     name: service.name,
      //     startTime: startDateTime,
      //     duration: service.duration,
      //     cost: service.cost,
      //     colorID: service.colorID,
      //   );
      //   appointmentServices.add(appointmentService);
      // }

      String appointmentID = appointment == null ? '' : appointment!.id;

      Appointment newAppointment = Appointment(
        id: appointmentID,
        clientName: selectedClient!.fullName,
        clientDocID: selectedClient!.id,
        clientPhone: selectedClient!.phone,
        clientEmail: selectedClient!.email,
        clientImageURL: selectedClient!.imageURL,
        creationDate: DateTime.now(),
        creator: AppointmentCreator
            .business, // will be used as enum AppointmentCreator
        lastEditor: AppointmentCreator
            .business, // will be used as enum AppointmentCreator
        date: startDateTime,
        paymentStatus: PaymentStatus.unpaid,
        services: updatedServices,
        status: AppointmentStatus.confirmed,
        notes: _notesController.text,
      );

      if (appointment == null) {
        await appointmentsMgr.submitNewAppointment(newAppointment);
        Navigator.pop(context);
        showSuccessFlash(
          context: context,
          successTitle:
              Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
          successBody: Languages.of(context)!
              .appointmentCreatedSuccessfullyBody
              .toTitleCase(),
          successColor: successPrimaryColor,
        );
        Navigator.pop(context);
      } else {
        await appointmentsMgr.updateAppointment(newAppointment);
        Navigator.pop(context);
        showSuccessFlash(
          context: context,
          successTitle:
              Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
          successBody: Languages.of(context)!
              .appointmentUpdatedSuccessfullyBody
              .toTitleCase(),
          successColor: successPrimaryColor,
        );
        Navigator.pop(context);
      }
    }
  }

  renderServices() {
    List<Widget> widgetList =
        selectedServices.map((AppointmentService service) {
      return Column(
        children: [
          CustomSlidable(
            customSlidableProps: CustomSlidableProps(
              groupTag: 'appointment',
              deleteAction: () => removeService(service),
              child: AppointmentServiceCard(
                // key: ValueKey(service.id),
                appointmentServiceCardProps: AppointmentServiceCardProps(
                  enabled: false,
                  withNavigation: false,
                  serviceDetails: service,
                  title: service.name,
                  subTitle: durationToFormat(duration: service.duration),
                ),
              ),
            ),
          ),
          SizedBox(
            height: rSize(15),
          ),
        ],
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
                  Languages.of(context)!.servicesLabel.toTitleCase(),
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
                            text: Languages.of(context)!
                                .addServiceLabel
                                .toTitleCase(),
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
                  text: Languages.of(context)!.chooseServiceLabel.toTitleCase(),
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
                    Languages.of(context)!.startDateTimeLabel.toTitleCase(),
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
                    locale: getCurrentLocale(context),
                  ),
                  onTap: () => showPickerDateTimeModal(
                    pickerDateTimeModalProps: PickerDateTimeModalProps(
                      context: context,
                      minimumDate: getMinDate(),
                      primaryButtonText:
                          Languages.of(context)!.saveLabel.toTitleCase(),
                      secondaryButtonText:
                          Languages.of(context)!.cancelLabel.toTitleCase(),
                      minuteInterval: 5,
                      initialDateTime: startDateTime,
                      title: Languages.of(context)!
                          .startDateTimeLabel
                          .toTitleCase(),
                      onDateTimeChanged: (DateTime value) => {
                        setState(() {
                          startDateTimeTemp = value;
                        }),
                      },
                      primaryAction: () => {
                        setState(() {
                          startDateTime = startDateTimeTemp;
                          endTime = startDateTime.add(getServicesDuration());
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
                  child: Text(
                    Languages.of(context)!.endLabel.toTitleCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                CustomInputFieldButton(
                  isDisabled: true,
                  text: getDateTimeFormat(
                    dateTime: endTime,
                    format: 'HH:mm',
                    locale: getCurrentLocale(context),
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
                          defaultImage: const AssetImage(
                            'assets/images/avatar_female.png',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: rSize(15),
                      ),
                      Expanded(
                        child: Text(
                          Languages.of(context)!
                              .walkInClientLabel
                              .toCapitalized(),
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
                withDelete: widget.appointment != null ? false : true,
                enabled: false,
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
                Languages.of(context)!.notesLabel.toTitleCase(),
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
      child: CustomContainer(
        imagePath: 'assets/images/background4.png',
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            customAppBarProps: CustomAppBarProps(
              titleText: appointment != null
                  ? Languages.of(context)!.editAppointmentLabel.toTitleCase()
                  : Languages.of(context)!.newAppointmentLabel.toTitleCase(),
              withBack: true,
              isTransparent: true,
              withSave: true,
              saveText: Languages.of(context)!.saveLabel,
              saveTap: () => {saveAppointment()},
            ),
          ),
          body: SafeArea(
            top: false,
            left: false,
            right: false,
            child: Column(
              children: [
                SizedBox(
                  height: rSize(20),
                ),
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
      ),
    );
  }
}
