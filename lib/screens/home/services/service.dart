import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/services_mgr.dart';
import 'package:appointments/utils/formats.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_color_picker.dart';
import 'package:appointments/widget/duration_picker_modal.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/image_picker_modal.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ServiceWidget extends StatefulWidget {
  final Service? service;
  const ServiceWidget({Key? key, this.service}) : super(key: key);

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  final ItemScrollController colorScrollController = ItemScrollController();
  final ItemPositionsListener colorPositionsListener =
      ItemPositionsListener.create();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _messageToClientController =
      TextEditingController();

  Color selectedColor = Colors.green;
  Color selectedColorTemp = Colors.green;
  bool onlineBooking = true;

  List<int> hoursData = [0, 1, 2, 3, 4, 5, 6, 7];
  List<int> minutesData = [0, 15, 30, 45];

  int selectedHours = 0;
  int selectedHoursIdx = 0;
  int selectedMinutes = 0;
  int selectedMinutesIdx = 0;

  List<Color> mediaList = [];

  @override
  void initState() {
    super.initState();

    if (widget.service != null) {
      _nameController.text = widget.service!.name;
      _priceController.text = widget.service!.cost.toString();
      _descriptionController.text = widget.service!.description ?? '';
      _messageToClientController.text = widget.service!.noteMessage ?? '';
      selectedHoursIdx = hoursData.indexWhere(
          (element) => element == (widget.service!.duration.inHours.toInt()));
      selectedHours =
          selectedHoursIdx > 0 ? hoursData[selectedHoursIdx] : hoursData[0];
      selectedMinutesIdx = minutesData.indexWhere((element) =>
          element ==
          (widget.service!.duration.inMinutes.remainder(60).toInt()));
      selectedMinutes = selectedMinutesIdx > 0
          ? minutesData[selectedMinutesIdx]
          : minutesData[0];
      onlineBooking = widget.service!.onlineBooking;
      selectedColor = Color(widget.service!.colorID);
      selectedColorTemp = Color(widget.service!.colorID);
    }
    colorPositionsListener.itemPositions.addListener(() {});
    _nameController.addListener(() => setState(() {}));
    _priceController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
    _messageToClientController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _messageToClientController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> mediaCards() {
      List<Widget> widgetList = mediaList.map((item) {
        return EaseInAnimation(
          beginAnimation: 0.98,
          onTap: () => {},
          child: Container(
            width: rSize(100),
            height: rSize(100),
            margin: EdgeInsets.only(
              right: rSize(15),
            ),
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  rSize(10),
                ),
              ),
            ),
            child: Image.asset(
              'assets/images/avatar_female.png',
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
        );
      }).toList();
      widgetList.insert(
        0,
        EaseInAnimation(
          onTap: () => {
            showImagePickerModal(
              imagePickerModalProps: ImagePickerModalProps(
                context: context,
                saveImage: () => {},
              ),
            )
          },
          beginAnimation: 0.98,
          child: Padding(
            padding: EdgeInsets.only(right: rSize(20)),
            child: DottedBorder(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderType: BorderType.RRect,
              dashPattern: [rSize(6), rSize(4)],
              strokeWidth: rSize(1),
              radius: Radius.circular(
                rSize(10),
              ),
              child: SizedBox(
                width: rSize(100),
                height: rSize(100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomIcon(
                      customIconProps: CustomIconProps(
                        icon: null,
                        backgroundColor: Colors.transparent,
                        path: 'assets/icons/camera.png',
                        containerSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: rSize(2),
                    ),
                    Text(
                      'Add Media',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontSize: rSize(12),
                          ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      return widgetList;
    }

    Widget renderServiceColors() {
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
              'Service Color',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          EaseInAnimation(
            onTap: () => showColorPicker(
              colorPickerProps: ColorPickerProps(
                context: context,
                pickerColor: selectedColor,
                onColorChanged: (newColor) => setState(() {
                  selectedColorTemp = newColor;
                }),
                primaryAction: () => setState(() {
                  selectedColor = selectedColorTemp;
                }),
              ),
            ),
            child: Container(
              width: rSize(40),
              height: rSize(40),
              decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(rSize(10)),
                ),
              ),
            ),
          )
        ],
      );
    }

    Widget renderPermissions() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: rSize(5),
            ),
            child: Text(
              'Permissions',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Allow Clients to Book Online',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  EaseInAnimation(
                    onTap: () => {
                      showBottomModal(
                        bottomModalProps: BottomModalProps(
                          context: context,
                          enableDrag: true,
                          // showDragPen: true,
                          centerTitle: true,
                          title: 'Allow Clients to Book Online',
                          child: Text(
                            'If switched off clients will not be able to book this Service using the app. You will have to manually add appointments to your calendar.',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      )
                    },
                    child: CustomIcon(
                      customIconProps: CustomIconProps(
                        icon: null,
                        path: 'assets/icons/question.png',
                        containerSize: 25,
                        backgroundColor: Colors.transparent,
                        iconColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: rSize(10),
                  ),
                  Transform.scale(
                    scale: rSize(1.4),
                    alignment: Alignment.center,
                    child: Switch(
                      onChanged: (bool value) {
                        setState(() {
                          onlineBooking = value;
                        });
                      },
                      splashRadius: 0,
                      activeColor: Theme.of(context).colorScheme.primary,
                      inactiveThumbColor:
                          Theme.of(context).colorScheme.onBackground,
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      value: onlineBooking,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      );
    }

    deleteService() {
      final servicesMgr = Provider.of<ServicesMgr>(context, listen: false);
      servicesMgr.deleteService(widget.service!);
      Navigator.pop(context);
    }

    showDeleteServiceModal() {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: 'Delete',
          secondaryButtonText: 'Back',
          deleteCancelModal: true,
          footerButton: ModalFooter.both,
          primaryAction: () => deleteService(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIcon(
                customIconProps: CustomIconProps(
                  icon: null,
                  path: 'assets/icons/trash.png',
                  withPadding: true,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  iconColor: Colors.white,
                  containerSize: rSize(80),
                  contentPadding: rSize(20),
                ),
              ),
              SizedBox(
                height: rSize(30),
              ),
              Text(
                'Delete this service?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'Action can not be undone',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      );
    }

    Widget renderFooter() {
      return Padding(
        padding: EdgeInsets.only(
          right: rSize(20),
          left: rSize(20),
          top: rSize(40),
        ),
        child: CustomButton(
          customButtonProps: CustomButtonProps(
            onTap: () => {
              showDeleteServiceModal(),
            },
            text: 'Delete Service',
            isPrimary: true,
            // isSecondary: true,
            textColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    }

    Widget renderMessageToClient() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: rSize(5),
                  left: rSize(10),
                  right: rSize(10),
                ),
                child: Text(
                  'Message to Client',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              EaseInAnimation(
                onTap: () => {
                  showBottomModal(
                    bottomModalProps: BottomModalProps(
                      context: context,
                      enableDrag: true,
                      // showDragPen: true,
                      centerTitle: true,
                      title: 'Message to Client',
                      child: Text(
                        'This message will be sent to your client before the appointment. E.g Please do not eat 1 hour before the appointment.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  )
                },
                child: CustomIcon(
                  customIconProps: CustomIconProps(
                    icon: null,
                    path: 'assets/icons/question.png',
                    containerSize: 25,
                    backgroundColor: Colors.transparent,
                    iconColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: rSize(5),
          ),
          SizedBox(
            height: rSize(120),
            child: CustomInputField(
              customInputFieldProps: CustomInputFieldProps(
                controller: _messageToClientController,
                isDescription: true,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ],
      );
    }

    Widget renderMedia() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
            ),
            child: Text(
              'Media',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              // horizontal: rSize(20),
              top: rSize(15),
            ),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: mediaCards(),
            ),
          ),
        ],
      );
    }

    Widget renderDescription() {
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
              'Service Description',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: rSize(120),
            child: CustomInputField(
              customInputFieldProps: CustomInputFieldProps(
                hintText:
                    'Example: This relaxing service included an herbal soak.',
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                isDescription: true,
              ),
            ),
          ),
        ],
      );
    }

    Widget renderPriceDuration() {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
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
                      'Price',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  CustomInputField(
                    customInputFieldProps: CustomInputFieldProps(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      isCurrency: true,
                    ),
                  ),
                ],
              ),
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
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: rSize(5),
                      left: rSize(10),
                      right: rSize(10),
                    ),
                    child: Text(
                      'Duration',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  CustomInputFieldButton(
                    text: durationToFormat(
                      duration: Duration(
                        hours: selectedHours,
                        minutes: selectedMinutes,
                      ),
                    ),
                    onTap: () => showDurationPickerModal(
                      durationPickerModalProps: DurationPickerModalProps(
                        context: context,
                        hoursData: hoursData,
                        minutesData: minutesData,
                        selectedHours: selectedHoursIdx,
                        selectedMinutes: selectedMinutesIdx,
                        primaryButtonText: 'Save',
                        secondaryButtonText: 'Cancel',
                        saveMinutes: (value) => {
                          setState(() {
                            selectedMinutes = minutesData[value];
                          })
                        },
                        saveHours: (value) => {
                          setState(() {
                            selectedHours = hoursData[value];
                          })
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]);
    }

    Widget renderServiceName() {
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
              'Service Name',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: rSize(5),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _nameController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      );
    }

    saveService() {
      final servicesMgr = Provider.of<ServicesMgr>(context, listen: false);
      String serviceID = widget.service == null ? '' : widget.service!.id;
      Service service = Service(
        id: serviceID,
        name: _nameController.text,
        cost: double.parse(_priceController.text),
        duration: Duration(hours: selectedHours, minutes: selectedMinutes),
        colorID: selectedColor.value,
        onlineBooking: onlineBooking,
        description: _descriptionController.text,
        noteMessage: _messageToClientController.text,
      );

      if (widget.service == null) {
        servicesMgr.submitNewService(service);
        showSuccessFlash(
          context: context,
          successTitle: 'Submitted!',
          successBody: 'Service was uploaded to DB successfully!',
          successColor: successPrimaryColor,
        );
      } else {
        // update
        servicesMgr.updateService(service);
        showSuccessFlash(
          context: context,
          successTitle: 'Updated!',
          successBody: 'Service was updated successfully!',
          successColor: successPrimaryColor,
        );
      }
      Navigator.pop(context);
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
            titleText: 'New Service',
            withBack: true,
            withSave: true,
            saveTap: () => saveService(),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
            vertical: rSize(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              renderServiceName(),
              SizedBox(
                height: rSize(20),
              ),
              renderPriceDuration(),
              SizedBox(
                height: rSize(20),
              ),
              renderServiceColors(),
              SizedBox(
                height: rSize(20),
              ),
              renderDescription(),
              SizedBox(
                height: rSize(20),
              ),
              renderMedia(),
              SizedBox(
                height: rSize(30),
              ),
              renderMessageToClient(),
              SizedBox(
                height: rSize(20),
              ),
              renderPermissions(),
              widget.service != null ? renderFooter() : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
