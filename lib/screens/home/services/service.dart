import 'dart:io';

import 'package:appointments/data_types/components.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/services_mgr.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/utils/validations.dart';
import 'package:appointments/widget/custom/custom_color_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/duration_picker_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/image_picker_modal.dart';
import 'package:common_widgets/placeholders.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/storage_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color selectedColor = Colors.green;
  Color selectedColorTemp = Colors.green;
  bool onlineBooking = true;
  bool _isLoading = false;
  bool isSaveDisabled = true;
  bool autoValidate = false;
  List<int> hoursData = [0, 1, 2, 3, 4, 5, 6, 7];
  List<int> minutesData = [0, 15, 30, 45];

  int selectedHours = 0;
  int selectedHoursIdx = 1;
  int selectedMinutes = 0;
  int selectedMinutesIdx = 0;

  Map<String, String> mediaList = {};
  Map<String, File> mediaListToUpload = {};

  @override
  void initState() {
    super.initState();

    if (widget.service != null) {
      _isLoading = true;
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
      mediaList = widget.service!.imagesURL!;
      _isLoading = false;
    }
    colorPositionsListener.itemPositions.addListener(() {});
    _nameController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
    _priceController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
    _descriptionController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
    _messageToClientController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
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
    deleteServicePhoto(String fileName) async {
      final servicesMgr = Provider.of<ServicesMgr>(context, listen: false);
      await servicesMgr.deleteServiceImage(
        widget.service!.id,
        widget.service!.name,
        fileName,
      );
      setState(() {});
    }

    removeServicePhoto({required String imageKey, bool isUrl = true}) async {
      showBottomModal(
        bottomModalProps: BottomModalProps(
          context: context,
          centerTitle: true,
          primaryButtonText: Languages.of(context)!.deleteLabel.toCapitalized(),
          secondaryButtonText: Languages.of(context)!.backLabel.toCapitalized(),
          deleteCancelModal: true,
          primaryAction: () async => {
            showLoaderDialog(context),
            if (isUrl)
              deleteServicePhoto(imageKey)
            else
              {
                setState(() {
                  mediaListToUpload
                      .removeWhere((key, value) => key == imageKey);
                })
              },
            Navigator.pop(context),
            showSuccessFlash(
              context: context,
              successColor: successPrimaryColor,
              successTitle:
                  Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
              successBody: Languages.of(context)!
                  .wpPhotoDeletedSuccessfullyBody
                  .toCapitalized(),
            ),
          },
          footerButton: ModalFooter.both,
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
                '${Languages.of(context)!.deletePhotoLabel.toTitleCase()}?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.actionUndoneLabel.toCapitalized(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      );
    }

    List<Widget> mediaCards() {
      List<Widget> widgetList = [];

      for (var servicePhoto in mediaList.entries) {
        widgetList.add(
          Padding(
            padding: EdgeInsets.only(
              left: isRtl(context) ? 0 : rSize(15),
              right: isRtl(context) ? rSize(15) : 0,
            ),
            child: EaseInAnimation(
              beginAnimation: 0.98,
              onTap: () => {
                removeServicePhoto(imageKey: servicePhoto.key),
              },
              child: CachedNetworkImage(
                imageUrl: servicePhoto.value,
                imageBuilder: (context, imageProvider) => Container(
                  width: rSize(100),
                  height: rSize(100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(rSize(10))),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.background,
                  highlightColor: Theme.of(context).colorScheme.onBackground,
                  child: ImagePlaceHolder(
                    width: rSize(100),
                    height: rSize(100),
                    borderRadius: rSize(10),
                  ),
                ),
                // errorWidget: (context, url, error) => errorWidget,
              ),
            ),
          ),
        );
      }
      for (var servicePhoto in mediaListToUpload.entries) {
        widgetList.add(
          Padding(
            padding: EdgeInsets.only(
              left: isRtl(context) ? 0 : rSize(15),
              right: isRtl(context) ? rSize(15) : 0,
            ),
            child: EaseInAnimation(
              beginAnimation: 0.98,
              onTap: () => {
                removeServicePhoto(imageKey: servicePhoto.key, isUrl: false),
              },
              child: Container(
                width: rSize(100),
                height: rSize(100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(rSize(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      servicePhoto.value,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
      widgetList.insert(
        0,
        DottedBorder(
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
                    isDisabled: false,
                    onTap: () => {
                      showImagePickerModal(
                          imagePickerModalProps: ImagePickerModalProps(
                        context: context,
                        cancelText:
                            Languages.of(context)!.cancelLabel.toTitleCase(),
                        deleteText:
                            Languages.of(context)!.deleteLabel.toTitleCase(),
                        takePhotoText:
                            Languages.of(context)!.takePhotoLabel.toTitleCase(),
                        libraryText: Languages.of(context)!
                            .chooseFromLibraryLabel
                            .toTitleCase(),
                        isCircleCropStyle: false,
                        saveImage: (File imageFile) {
                          setState(() {
                            var uid = const Uuid().v4();
                            mediaListToUpload[uid] = imageFile;
                            isSaveDisabled = false;
                          });
                        },
                      ))
                    },
                    icon: null,
                    backgroundColor: Colors.transparent,
                    path: 'assets/icons/camera.png',
                    iconColor: Theme.of(context).colorScheme.primary,
                    containerSize: 40,
                  ),
                ),
                SizedBox(
                  height: rSize(2),
                ),
                Text(
                  Languages.of(context)!.addMediaLabel.toTitleCase(),
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: rSize(12),
                      ),
                )
              ],
            ),
          ),
        ),
      );

      return widgetList;
    }

    Widget renderServiceColors() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: rSize(10)),
            child: Text(
              Languages.of(context)!.colorLabel.toTitleCase(),
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
                  isSaveDisabled = false;
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
              Languages.of(context)!.permissionsLabel.toTitleCase(),
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
                Languages.of(context)!.clientBookPermissionLabel.toTitleCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomIcon(
                    customIconProps: CustomIconProps(
                      isDisabled: false,
                      onTap: () => {
                        showBottomModal(
                          bottomModalProps: BottomModalProps(
                            context: context,
                            enableDrag: true,
                            centerTitle: true,
                            title: Languages.of(context)!
                                .clientBookPermissionLabel
                                .toTitleCase(),
                            child: Text(
                              Languages.of(context)!
                                  .clientBookPermissionModalBody
                                  .toCapitalized(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        )
                      },
                      icon: null,
                      path: 'assets/icons/question.png',
                      containerSize: 25,
                      backgroundColor: Colors.transparent,
                      iconColor: Theme.of(context).colorScheme.primary,
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
                          isSaveDisabled = false;
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
          primaryButtonText: Languages.of(context)!.deleteLabel.toTitleCase(),
          secondaryButtonText: Languages.of(context)!.backLabel.toTitleCase(),
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
                '${Languages.of(context)!.deleteThisServiceLabel.toTitleCase()}?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                Languages.of(context)!.actionUndoneLabel.toCapitalized(),
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
            text: Languages.of(context)!.deleteServiceLabel.toTitleCase(),
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
          Padding(
            padding: EdgeInsets.only(
              bottom: rSize(5),
              left: rSize(10),
              right: rSize(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  Languages.of(context)!.messageToClientLabel.toTitleCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                CustomIcon(
                  customIconProps: CustomIconProps(
                    isDisabled: false,
                    onTap: () => {
                      showBottomModal(
                        bottomModalProps: BottomModalProps(
                          context: context,
                          enableDrag: true,
                          // showDragPen: true,
                          centerTitle: true,
                          title: Languages.of(context)!
                              .messageToClientLabel
                              .toTitleCase(),
                          child: Text(
                            Languages.of(context)!
                                .messageToClientModalBody
                                .toCapitalized(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      )
                    },
                    icon: null,
                    path: 'assets/icons/question.png',
                    containerSize: 25,
                    backgroundColor: Colors.transparent,
                    iconColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
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
              Languages.of(context)!.mediaLabel.toTitleCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: rSize(5),
              right: rSize(5),
              top: rSize(10),
              bottom: rSize(10),
            ),
            scrollDirection: Axis.horizontal,
            child: Visibility(
              visible: !_isLoading,
              replacement: CustomLoadingIndicator(
                customLoadingIndicatorProps:
                    CustomLoadingIndicatorProps(containerSize: 100),
              ),
              child: Row(
                children: mediaCards(),
              ),
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
              Languages.of(context)!.descriptionLabel.toTitleCase(),
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
                      Languages.of(context)!.priceLabel.toTitleCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  CustomInputField(
                    customInputFieldProps: CustomInputFieldProps(
                      controller: _priceController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(5),
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      isCurrency: true,
                      validator: priceValidation,
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
                      Languages.of(context)!.durationLabel.toTitleCase(),
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
                        primaryButtonText:
                            Languages.of(context)!.saveLabel.toTitleCase(),
                        secondaryButtonText:
                            Languages.of(context)!.cancelLabel.toTitleCase(),
                        hoursText:
                            Languages.of(context)!.hoursLabel.toTitleCase(),
                        minsText:
                            Languages.of(context)!.minsLabel.toTitleCase(),
                        saveMinutes: (value) => {
                          setState(() {
                            selectedMinutes = minutesData[value];
                            isSaveDisabled = false;
                          })
                        },
                        saveHours: (value) => {
                          setState(() {
                            selectedHours = hoursData[value];
                            isSaveDisabled = false;
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
              Languages.of(context)!.serviceNameLabel.toTitleCase(),
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
              validator: emptyValidation,
            ),
          ),
        ],
      );
    }

    getResizedMediaToUpload() async {
      Map<String, File> resizedMediaListToUpload = {};
      for (var element in mediaListToUpload.entries) {
        resizedMediaListToUpload[element.key] =
            (await compressImageNative(path: element.value.absolute.path))!;
      }
      return resizedMediaListToUpload;
    }

    saveService() async {
      final form = _formKey.currentState;
      setState(() {
        autoValidate = true;
      });
      if (form!.validate()) {
        showLoaderDialog(context);
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
          Map<String, File> resizedMediaListToUpload =
              await getResizedMediaToUpload();
          await servicesMgr.submitNewService(
            service,
            resizedMediaListToUpload,
          );
          showSuccessFlash(
            context: context,
            successTitle:
                Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
            successBody: Languages.of(context)!
                .serviceCreatedSuccessfullyBody
                .toCapitalized(),
            successColor: successPrimaryColor,
          );
          Navigator.pop(context);
        } else {
          Map<String, File> resizedMediaListToUpload =
              await getResizedMediaToUpload();
          await servicesMgr.updateService(
            service,
            resizedMediaListToUpload.values.toList(),
          );
          showSuccessFlash(
            context: context,
            successTitle:
                Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
            successBody: Languages.of(context)!
                .serviceUpdatedSuccessfullyBody
                .toCapitalized(),
            successColor: successPrimaryColor,
          );
          Navigator.pop(context);
        }
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
            titleText: widget.service != null
                ? Languages.of(context)!.editServiceLabel.toTitleCase()
                : Languages.of(context)!.newServiceLabel.toTitleCase(),
            withBack: true,
            withSave: true,
            saveText: Languages.of(context)!.saveLabel,
            withSaveDisabled: isSaveDisabled,
            saveTap: () => {
              saveService(),
            },
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
            vertical: rSize(40),
          ),
          child: Form(
            key: _formKey,
            autovalidateMode:
                autoValidate ? AutovalidateMode.onUserInteraction : null,
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
                Visibility(
                  visible: widget.service != null,
                  child: renderFooter(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
