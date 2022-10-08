import 'dart:io';

import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/utils/validations.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/image_picker_modal.dart';
import 'package:common_widgets/picker_date_time_modal.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ClientWidget extends StatefulWidget {
  final Client? client;
  const ClientWidget({Key? key, this.client}) : super(key: key);

  @override
  State<ClientWidget> createState() => _ClientWidgetState();
}

class _ClientWidgetState extends State<ClientWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _discountController =
      TextEditingController(text: '0');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool trustedClient = true;
  bool autoValidate = false;
  File? _imageFile;
  String imageUrl = '';
  String imagePath = '';
  bool _isImageFileChanged = false;
  bool _isLoading = true;
  bool isSaveDisabled = true;

  DateTime? birthdayDate;
  DateTime? birthdayDateTemp;
  DateTime today = DateTime.now();
  late DateTime maximumDate = DateTime(today.year - 5, today.month, today.day);

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      final clientMgr = Provider.of<ClientsMgr>(context, listen: false);
      _nameController.text = widget.client!.fullName;
      _phoneController.text = widget.client!.phone;
      _emailController.text = widget.client!.email;
      _addressController.text = widget.client!.address;
      _noteController.text = widget.client!.generalNotes!;
      _discountController.text = widget.client!.discount.toString();
      birthdayDate = widget.client!.birthday;
      imagePath = widget.client!.imagePath;
      if (imagePath.isNotEmpty) {
        clientMgr.getClientImage(imagePath).then(
              (url) => {
                if (url == 'notFound')
                  {
                    setState(
                      (() {
                        _isLoading = false;
                      }),
                    ),
                  }
                else
                  {
                    setState(
                      (() {
                        _isLoading = false;
                        _isLoading = false;
                        imageUrl = url;
                      }),
                    ),
                  },
              },
            );
      }
    }

    _nameController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
    _phoneController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
    _emailController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
    _addressController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
    _noteController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
    _discountController.selection = const TextSelection(
      baseOffset: 0,
      extentOffset: 1,
    );
    _discountController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                'Is trusted client',
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
                          title: 'Trusted Client',
                          child: Text(
                            'If switched off clients will not be able automatically book an appointment.',
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
                          trustedClient = value;
                          isSaveDisabled = false;
                        });
                      },
                      splashRadius: 0,
                      activeColor: Theme.of(context).colorScheme.primary,
                      inactiveThumbColor:
                          Theme.of(context).colorScheme.onBackground,
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      value: trustedClient,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      );
    }

    Widget renderNotes() {
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
                hintText: 'Example: Will add something here',
                controller: _noteController,
                keyboardType: TextInputType.multiline,
                isDescription: true,
              ),
            ),
          ),
        ],
      );
    }

    Widget renderClientName() {
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
              'Full Name',
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
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
              ],
              validator: emptyValidation,
            ),
          ),
        ],
      );
    }

    Widget renderClientPhone() {
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
              'Phone Number',
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
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: mobileValidation,
            ),
          ),
        ],
      );
    }

    Widget renderClientEmail() {
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
              'Email Address',
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
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              validator: emailValidation,
            ),
          ),
        ],
      );
    }

    Widget renderClientAddress() {
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
              'Address',
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
              controller: _addressController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      );
    }

    Widget renderBirthdayPicker() {
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
              'Birthday',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          CustomInputFieldButton(
            text: getDateTimeFormat(
              isDayOfWeek: true,
              dateTime: birthdayDate,
              format: 'dd MMM yyyy',
            ),
            onTap: () => showPickerDateTimeModal(
              pickerDateTimeModalProps: PickerDateTimeModalProps(
                context: context,
                maximumDate: maximumDate,
                initialDateTime: birthdayDate ?? maximumDate,
                mode: CupertinoDatePickerMode.date,
                title: 'Birthday',
                onDateTimeChanged: (DateTime value) => {
                  setState(() {
                    birthdayDateTemp = value;
                  }),
                },
                primaryAction: () => {
                  setState(() {
                    birthdayDate = birthdayDateTemp;
                    isSaveDisabled = false;
                  }),
                },
              ),
            ),
          ),
        ],
      );
    }

    Widget renderClientDiscount() {
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
              'Discount',
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
                controller: _discountController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  LimitRangeTextInputFormatter(1, 100),
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                prefixIcon: CustomIcon(
                  customIconProps: CustomIconProps(
                    icon: null,
                    path: 'assets/icons/percent.png',
                    backgroundColor: Colors.transparent,
                    containerSize: 25,
                  ),
                )),
          ),
        ],
      );
    }

    ImageProvider<Object>? getBackgroundImage() {
      if (_imageFile != null) {
        return FileImage(_imageFile!);
      } else if (imageUrl.isNotEmpty) {
        return CachedNetworkImageProvider(imageUrl);
      }
      return null;
    }

    Widget renderAvatar() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomAvatar(
            customAvatarProps: CustomAvatarProps(
                radius: rSize(100),
                editable: true,
                circleShape: false,
                rectangleShape: true,
                defaultImage: const AssetImage(
                  'assets/images/avatar_female.png',
                ),
                enable: true,
                isLoading: _isLoading,
                backgroundImage: getBackgroundImage(),
                onTap: () => {
                      showImagePickerModal(
                        imagePickerModalProps: ImagePickerModalProps(
                          context: context,
                          saveImage: (File? imageFile) {
                            setState(() {
                              _imageFile = imageFile;
                              isSaveDisabled = false;
                              _isImageFileChanged = true;
                            });
                          },
                        ),
                      )
                    }),
          )
        ],
      );
    }

    saveClient() async {
      final form = _formKey.currentState;
      if (form!.validate()) {
        showLoaderDialog(context);
        final clientMgr = Provider.of<ClientsMgr>(context, listen: false);
        String clientID = widget.client == null ? '' : widget.client!.id;
        if (_imageFile != null && _isImageFileChanged) {
          if (imagePath.isEmpty) {
            imagePath = const Uuid().v4();
            await clientMgr.uploadClientImage(_imageFile!, imagePath);
          } else {
            await clientMgr.uploadClientImage(_imageFile!, imagePath);
          }
        }
        Client client = Client(
          id: clientID,
          fullName: _nameController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          email: _emailController.text,
          creationDate: DateTime.now(),
          birthday: birthdayDate,
          generalNotes: _noteController.text,
          discount: double.parse(_discountController.text),
          isTrusted: trustedClient,
          acceptedDate: DateTime.now(),
          imagePath: imagePath,
        );

        if (widget.client == null) {
          await clientMgr.submitNewClient(client);
          Navigator.pop(context);
          showSuccessFlash(
            context: context,
            successTitle: 'Submitted!',
            successBody: 'Client was added to DB successfully!',
            successColor: successPrimaryColor,
          );
          Navigator.pop(context);
        } else {
          await clientMgr.updateClient(client);
          Navigator.pop(context);
          showSuccessFlash(
            context: context,
            successTitle: 'Updated!',
            successBody: 'Client was updated successfully!',
            successColor: successPrimaryColor,
          );
          Navigator.pop(context);
        }
      }
      setState(() {
        autoValidate = true;
      });
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
            titleText: widget.client != null ? 'Client Details' : 'New Client',
            withBack: true,
            withSave: true,
            withSaveDisabled: isSaveDisabled,
            saveTap: () => saveClient(),
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
                renderAvatar(),
                SizedBox(
                  height: rSize(20),
                ),
                renderClientName(),
                SizedBox(
                  height: rSize(20),
                ),
                renderClientPhone(),
                SizedBox(
                  height: rSize(20),
                ),
                renderClientEmail(),
                SizedBox(
                  height: rSize(20),
                ),
                renderClientAddress(),
                SizedBox(
                  height: rSize(20),
                ),
                Row(
                  children: [
                    Expanded(child: renderBirthdayPicker()),
                    SizedBox(
                      width: rSize(10),
                    ),
                    Expanded(child: renderClientDiscount()),
                  ],
                ),
                SizedBox(
                  height: rSize(20),
                ),
                renderNotes(),
                SizedBox(
                  height: rSize(40),
                ),
                renderPermissions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
