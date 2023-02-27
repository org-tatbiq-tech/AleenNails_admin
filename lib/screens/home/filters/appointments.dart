import 'package:appointments/data_types/components.dart';
import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/services_mgr.dart';
import 'package:appointments/utils/general.dart';
import 'package:appointments/widget/appointment/appointment_status.dart';
import 'package:appointments/widget/custom/custom_check_text.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentsFilter extends StatefulWidget {
  const AppointmentsFilter({Key? key}) : super(key: key);

  @override
  State<AppointmentsFilter> createState() => _AppointmentsFilterState();
}

class _AppointmentsFilterState extends State<AppointmentsFilter> {
  late DateTime startTime;
  late DateTime startTimeTemp;
  late DateTime endTime;
  late DateTime endTimeTemp;
  late DateTime endTimeMin;
  bool isSaveDisabled = true;
  DateTime today = DateTime.now();
  List<AppointmentStatus> fullAppointmentStatusList = [
    AppointmentStatus.cancelled,
    AppointmentStatus.confirmed,
    AppointmentStatus.finished,
    AppointmentStatus.noShow
  ];
  late List<AppointmentStatus> appointmentsStatusFilter = [];
  late List<Service> servicesFilter = [];

  @override
  void initState() {
    super.initState();
    appointmentsStatusFilter = fullAppointmentStatusList;
    setState(() {
      startTime = DateTime(
        today.year,
        today.month,
        today.day,
      );
      startTimeTemp = startTime;
      endTime = DateTime(
        today.year,
        today.month,
        today.day,
      );
      endTimeTemp = endTime;
      endTimeMin = startTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget renderDateRange() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: rSize(14)),
            child: Text(
              Languages.of(context)!.dateRange.toTitleCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        Languages.of(context)!.startLabel.toTitleCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    CustomInputFieldButton(
                      fontSize: 16,
                      text: getDateTimeFormat(
                        dateTime: startTime,
                        format: 'EEEE, dd-MMM',
                        locale: getCurrentLocale(context),
                      ),
                      onTap: () => showPickerDateTimeModal(
                        pickerDateTimeModalProps: PickerDateTimeModalProps(
                          mode: CupertinoDatePickerMode.date,
                          context: context,
                          minimumDate: DateTime(
                            today.year,
                            today.month,
                            today.day,
                          ),
                          initialDateTime: startTime,
                          primaryButtonText:
                              Languages.of(context)!.saveLabel.toTitleCase(),
                          secondaryButtonText:
                              Languages.of(context)!.cancelLabel.toTitleCase(),
                          title: Languages.of(context)!
                              .startTimeLabel
                              .toTitleCase(),
                          onDateTimeChanged: (DateTime value) => {
                            setState(() {
                              startTimeTemp = value;
                            }),
                          },
                          primaryAction: () => {
                            setState(() {
                              startTime = startTimeTemp;
                              endTimeMin = startTimeTemp;
                              if (startTime.isAfter(endTime)) {
                                endTime = startTimeTemp;
                              }
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    CustomInputFieldButton(
                      fontSize: 16,
                      text: getDateTimeFormat(
                        dateTime: endTime,
                        format: 'EEEE, dd-MMM',
                        locale: getCurrentLocale(context),
                      ),
                      onTap: () => showPickerDateTimeModal(
                        pickerDateTimeModalProps: PickerDateTimeModalProps(
                          mode: CupertinoDatePickerMode.date,
                          context: context,
                          minimumDate: endTimeMin,
                          initialDateTime: endTime,
                          primaryButtonText:
                              Languages.of(context)!.saveLabel.toTitleCase(),
                          secondaryButtonText:
                              Languages.of(context)!.cancelLabel.toTitleCase(),
                          title:
                              Languages.of(context)!.endTimeLabel.toTitleCase(),
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
          ),
        ],
      );
    }

    bool isStatusInFilter(AppointmentStatus status) {
      if (appointmentsStatusFilter.isNotEmpty &&
          appointmentsStatusFilter.contains(status)) {
        return true;
      }
      return false;
    }

    bool isServiceInFilter(Service service) {
      if (servicesFilter.isNotEmpty && servicesFilter.contains(service)) {
        return true;
      }
      return false;
    }

    onStatusClicked(AppointmentStatus status) {
      setState(() {
        if (appointmentsStatusFilter.contains(status)) {
          appointmentsStatusFilter.remove(status);
        } else {
          appointmentsStatusFilter.add(status);
        }
      });
    }

    onServiceClicked(Service service) {
      setState(() {
        if (servicesFilter.contains(service)) {
          servicesFilter.remove(service);
        } else {
          servicesFilter.add(service);
        }
      });
    }

    bool isAllStatusInFilter() {
      Set<AppointmentStatus> fullStatusList = fullAppointmentStatusList.toSet();
      Set<AppointmentStatus> appointmentsStatusFilterSet =
          appointmentsStatusFilter.toSet();
      return fullStatusList.difference(appointmentsStatusFilterSet).isEmpty;
    }

    bool isAllServicesInFilter() {
      final servicesMgr = Provider.of<ServicesMgr>(context, listen: false);
      Set<Service> fullServicesList = servicesMgr.services.toSet();
      Set<Service> serviceFilterSet = servicesFilter.toSet();
      return fullServicesList.intersection(serviceFilterSet).length ==
          fullServicesList.length;
    }

    onAllStatusClicked() {
      setState(() {
        appointmentsStatusFilter.addAll(fullAppointmentStatusList);
      });
    }

    onAllServicesClicked() {
      final servicesMgr = Provider.of<ServicesMgr>(context, listen: false);
      setState(() {
        servicesFilter.addAll(servicesMgr.services);
      });
    }

    Widget renderStatus() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: rSize(14)),
            child: Text(
              Languages.of(context)!.statusLabel.toTitleCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Wrap(
            runSpacing: rSize(10),
            spacing: rSize(10),
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            children: [
              CustomCheckText(
                customCheckTextProps: CustomCheckTextProps(
                  onClicked: () => onAllStatusClicked(),
                  text: Languages.of(context)!.allLabel,
                  isSelected: isAllStatusInFilter(),
                ),
              ),
              CustomCheckText(
                customCheckTextProps: CustomCheckTextProps(
                  onClicked: () => onStatusClicked(AppointmentStatus.cancelled),
                  text: getAppointmentStatusText(
                    AppointmentStatus.cancelled,
                    context,
                  ),
                  isSelected: isStatusInFilter(AppointmentStatus.cancelled),
                ),
              ),
              CustomCheckText(
                customCheckTextProps: CustomCheckTextProps(
                  onClicked: () => onStatusClicked(AppointmentStatus.confirmed),
                  text: getAppointmentStatusText(
                    AppointmentStatus.confirmed,
                    context,
                  ),
                  isSelected: isStatusInFilter(AppointmentStatus.confirmed),
                ),
              ),
              CustomCheckText(
                customCheckTextProps: CustomCheckTextProps(
                  onClicked: () => onStatusClicked(AppointmentStatus.finished),
                  text: getAppointmentStatusText(
                    AppointmentStatus.finished,
                    context,
                  ),
                  isSelected: isStatusInFilter(AppointmentStatus.finished),
                ),
              ),
              CustomCheckText(
                customCheckTextProps: CustomCheckTextProps(
                  onClicked: () => onStatusClicked(AppointmentStatus.noShow),
                  text: getAppointmentStatusText(
                    AppointmentStatus.noShow,
                    context,
                  ),
                  isSelected: isStatusInFilter(AppointmentStatus.noShow),
                ),
              ),
            ],
          ),
        ],
      );
    }

    List<Widget> getServicesWidgets() {
      final servicesMgr = Provider.of<ServicesMgr>(context, listen: false);
      List<Widget> servicesList = <Widget>[];
      for (var service in servicesMgr.services) {
        {
          servicesList.add(
            CustomCheckText(
              customCheckTextProps: CustomCheckTextProps(
                onClicked: () => onServiceClicked(service),
                text: service.name,
                isSelected: isServiceInFilter(service),
              ),
            ),
          );
        }
      }
      servicesList.insert(
        0,
        CustomCheckText(
          customCheckTextProps: CustomCheckTextProps(
            onClicked: () => onAllServicesClicked(),
            text: Languages.of(context)!.allLabel,
            isSelected: isAllServicesInFilter(),
          ),
        ),
      );
      return servicesList;
    }

    Widget renderServiceType() {
      final servicesMgr = Provider.of<ServicesMgr>(context, listen: false);
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: rSize(14)),
            child: Text(
              Languages.of(context)!.serviceType.toTitleCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          servicesMgr.initialized
              ? Wrap(
                  runSpacing: rSize(15),
                  spacing: rSize(10),
                  children: getServicesWidgets(),
                )
              : Text('data'),
        ],
      );
    }

    return Consumer<ServicesMgr>(
      builder: (context, servicesMgr, _) {
        return CustomContainer(
          imagePath: 'assets/images/background4.png',
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              customAppBarProps: CustomAppBarProps(
                titleText: Languages.of(context)!.filters.toTitleCase(),
                withBack: true,
                isTransparent: true,
                withSave: true,
                saveText: Languages.of(context)!.clearAll.toTitleCase(),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: rSize(30),
                      right: rSize(30),
                      top: rSize(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        renderDateRange(),
                        SizedBox(
                          height: rSize(30),
                        ),
                        renderStatus(),
                        SizedBox(
                          height: rSize(30),
                        ),
                        servicesMgr.initialized
                            ? renderServiceType()
                            : Text('dsadsadsa'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: rSize(30)),
                  child: CustomButton(
                    customButtonProps: CustomButtonProps(
                      onTap: () => {},
                      text: Languages.of(context)!.applyFilters,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
