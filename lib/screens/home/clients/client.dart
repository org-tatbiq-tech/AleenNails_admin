import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_input_field_button.dart';
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
  bool trustedClient = true;

  DateTime? birthdayDate;
  DateTime? birthdayDateTemp;

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      _nameController.text = widget.client!.fullName;
      _phoneController.text = widget.client!.phone;
      _emailController.text = widget.client!.email;
      _addressController.text = widget.client!.address;
      _noteController.text = widget.client!.generalNotes!;
      _discountController.text = widget.client!.discount.toString();
      birthdayDate = widget.client!.birthday;
    }

    _nameController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _addressController.addListener(() => setState(() {}));
    _noteController.addListener(() => setState(() {}));
    _discountController.selection = const TextSelection(
      baseOffset: 0,
      extentOffset: 1,
    );
    _discountController.addListener(() => setState(() {}));
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
                // maximumDate: DateTime.now(),
                initialDateTime: birthdayDate,
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
                enable: true,
                onTap: () => {
                      showImagePickerModal(
                        imagePickerModalProps: ImagePickerModalProps(
                          context: context,
                          saveImage: () => {},
                        ),
                      )
                    }),
          ),
        ],
      );
    }

    saveClient() {
      final clientMgr = Provider.of<ClientsMgr>(context, listen: false);
      String clientID = widget.client == null ? '' : widget.client!.id;
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
      );

      if (widget.client == null) {
        clientMgr.submitNewClient(client);
        showSuccessFlash(
          context: context,
          successTitle: 'Submitted!',
          successBody: 'Client was added to DB successfully!',
          successColor: successPrimaryColor,
        );
        Navigator.pop(context);
      } else {
        clientMgr.updateClient(client);
        showSuccessFlash(
          context: context,
          successTitle: 'Updated!',
          successBody: 'Client was updated successfully!',
          successColor: successPrimaryColor,
        );
        int count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });
      }
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
            titleText: 'New Client',
            withBack: true,
            withSave: true,
            saveTap: () => saveClient(),
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
    );
  }
}
