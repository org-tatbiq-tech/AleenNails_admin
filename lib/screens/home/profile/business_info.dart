import 'package:appointments/data_types/settings_components.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/screens/home/profile/business_location.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/utils/validations.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/page_transition.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BusinessInfo extends StatefulWidget {
  const BusinessInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BusinessInfoState();
  }
}

class BusinessInfoState extends State<BusinessInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _webController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSaveDisabled = true;
  bool autoValidate = false;
  CameraPosition? businessLocation;

  @override
  void initState() {
    super.initState();
    final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);

    _nameController.text = settingsMgr.profileManagement.businessInfo.name;
    _phoneController.text = settingsMgr.profileManagement.businessInfo.phone;
    _emailController.text = settingsMgr.profileManagement.businessInfo.email;
    _addressController.text =
        settingsMgr.profileManagement.businessInfo.address;
    _facebookController.text =
        settingsMgr.profileManagement.businessInfo.facebookUrl!;
    _instagramController.text =
        settingsMgr.profileManagement.businessInfo.instagramUrl!;
    _webController.text =
        settingsMgr.profileManagement.businessInfo.websiteUrl!;
    _descriptionController.text =
        settingsMgr.profileManagement.businessInfo.description!;

    if (settingsMgr.profileManagement.businessInfo.latitude != null &&
        settingsMgr.profileManagement.businessInfo.longitude != null) {
      businessLocation = CameraPosition(
        target: LatLng(
          settingsMgr.profileManagement.businessInfo.latitude!,
          settingsMgr.profileManagement.businessInfo.longitude!,
        ),
        zoom: 14.4746,
      );
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
    _facebookController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
    _instagramController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
    _webController.addListener(() => setState(() {
          isSaveDisabled = false;
        }));
    _descriptionController.addListener(() => setState(() {
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
    _facebookController.dispose();
    _instagramController.dispose();
    _webController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget renderSocialMedia() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
              bottom: rSize(5),
            ),
            child: Text(
              Languages.of(context)!.socialMediaLabel.toTitleCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _facebookController,
              hintText: Languages.of(context)!.facebookLabel.toTitleCase(),
              keyboardType: TextInputType.text,
              prefixIcon: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: rSize(10),
                  ),
                  CustomIcon(
                    customIconProps: CustomIconProps(
                      icon: null,
                      path: 'assets/icons/facebook.png',
                      backgroundColor: Colors.transparent,
                      iconColor: Theme.of(context).colorScheme.primary,
                      containerSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: rSize(10),
                  ),
                  Container(
                    width: rSize(1),
                    color: Theme.of(context).colorScheme.primary,
                    margin: EdgeInsets.symmetric(
                      vertical: rSize(6),
                    ),
                  ),
                  SizedBox(
                    width: rSize(10),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: rSize(15),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _instagramController,
              hintText: Languages.of(context)!.instagramLabel.toTitleCase(),
              keyboardType: TextInputType.text,
              prefixIcon: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: rSize(10),
                  ),
                  CustomIcon(
                    customIconProps: CustomIconProps(
                      icon: null,
                      path: 'assets/icons/instagram.png',
                      backgroundColor: Colors.transparent,
                      iconColor: Theme.of(context).colorScheme.primary,
                      containerSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: rSize(10),
                  ),
                  Container(
                    width: rSize(1),
                    color: Theme.of(context).colorScheme.primary,
                    margin: EdgeInsets.symmetric(
                      vertical: rSize(6),
                    ),
                  ),
                  SizedBox(
                    width: rSize(10),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: rSize(15),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _webController,
              hintText: Languages.of(context)!.websiteLabel.toTitleCase(),
              validator: validateUrl,
              keyboardType: TextInputType.text,
              prefixIcon: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: rSize(10),
                  ),
                  CustomIcon(
                    customIconProps: CustomIconProps(
                      icon: null,
                      path: 'assets/icons/internet.png',
                      backgroundColor: Colors.transparent,
                      iconColor: Theme.of(context).colorScheme.primary,
                      containerSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: rSize(10),
                  ),
                  Container(
                    width: rSize(1),
                    color: Theme.of(context).colorScheme.primary,
                    margin: EdgeInsets.symmetric(
                      vertical: rSize(6),
                    ),
                  ),
                  SizedBox(
                    width: rSize(10),
                  ),
                ],
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
              left: rSize(10),
              right: rSize(10),
              bottom: rSize(5),
            ),
            child: Text(
              Languages.of(context)!.businessDescriptionLabel.toTitleCase(),
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
                hintText: Languages.of(context)!
                    .businessDescriptionHint
                    .toCapitalized(),
                isDescription: true,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ],
      );
    }

    Widget renderEmail() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
              bottom: rSize(5),
            ),
            child: Text(
              Languages.of(context)!.emailAddressLabel.toTitleCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: emailValidation,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
            ),
          ),
        ],
      );
    }

    navigateToBusinessLocation() async {
      final result = await Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: BusinessLocation(
            storePosition: businessLocation,
          ),
        ),
      );
      if (result != null) {
        setState(() {
          businessLocation = result;
          isSaveDisabled = false;
        });
      }
    }

    Widget renderAddress() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
              bottom: rSize(5),
            ),
            child: Text(
              Languages.of(context)!.addressLabel.toTitleCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _addressController,
              keyboardType: TextInputType.text,
            ),
          ),
          SizedBox(
            height: rSize(20),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
              bottom: rSize(5),
            ),
            child: Text(
              Languages.of(context)!.locationLabel.toTitleCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CustomInputFieldButton(
                  text: Languages.of(context)!.updateBusinessLocationLabel,
                  onTap: () => navigateToBusinessLocation(),
                ),
              ),
              SizedBox(
                width: rSize(10),
              ),
              CustomIcon(
                customIconProps: CustomIconProps(
                  isDisabled: false,
                  onTap: () => {
                    showBottomModal(
                      bottomModalProps: BottomModalProps(
                        context: context,
                        centerTitle: true,
                        title:
                            Languages.of(context)!.locationLabel.toTitleCase(),
                        child: Text(
                          Languages.of(context)!
                              .blockedClientModalBody
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
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: (businessLocation != null)
                    ? CustomIcon(
                        customIconProps: CustomIconProps(
                          icon: null,
                          path: 'assets/icons/check.png',
                          containerSize: 25,
                          backgroundColor: Colors.transparent,
                          iconColor: successPrimaryColor,
                        ),
                      )
                    : CustomIcon(
                        customIconProps: CustomIconProps(
                          icon: null,
                          path: 'assets/icons/close.png',
                          containerSize: 25,
                          backgroundColor: Colors.transparent,
                          iconColor: Theme.of(context).colorScheme.error,
                        ),
                      ),
              ),
            ],
          ),
        ],
      );
    }

    Widget renderPhoneNumber() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
              bottom: rSize(5),
            ),
            child: Text(
              Languages.of(context)!.phoneNumberLabel.toTitleCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              validator: mobileValidation,
            ),
          ),
        ],
      );
    }

    Widget renderBusinessName() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
              bottom: rSize(5),
            ),
            child: Text(
              Languages.of(context)!.businessNameLabel.toTitleCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _nameController,
              keyboardType: TextInputType.text,
              validator: emptyValidation,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
            ),
          ),
        ],
      );
    }

    saveBusinessInfo() async {
      final form = _formKey.currentState;
      setState(() {
        autoValidate = true;
      });
      if (form!.validate()) {
        showLoaderDialog(context);
        final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);

        BusinessInfoComp newData = BusinessInfoComp(
          name: _nameController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          address: _addressController.text,
          description: _descriptionController.text,
          facebookUrl: _facebookController.text,
          instagramUrl: _instagramController.text,
          websiteUrl: _webController.text,
          longitude: businessLocation!.target.longitude,
          latitude: businessLocation!.target.latitude,
        );
        settingsMgr.profileManagement.businessInfo = newData;

        await settingsMgr.submitNewProfile();
        Navigator.pop(context);
        showSuccessFlash(
          context: context,
          successColor: successPrimaryColor,
          successBody:
              Languages.of(context)!.flashMessageSuccessTitle.toTitleCase(),
          successTitle: Languages.of(context)!
              .infoUpdatedSuccessfullyBody
              .toCapitalized(),
        );
        Navigator.pop(context);
      }
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
              titleText:
                  Languages.of(context)!.businessNameInfoLabel.toTitleCase(),
              isTransparent: true,
              withBack: true,
              withSave: true,
              saveText: Languages.of(context)!.saveLabel,
              withSaveDisabled: isSaveDisabled,
              saveTap: () => saveBusinessInfo(),
            ),
          ),
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
                  renderBusinessName(),
                  SizedBox(
                    height: rSize(20),
                  ),
                  renderPhoneNumber(),
                  SizedBox(
                    height: rSize(20),
                  ),
                  renderEmail(),
                  SizedBox(
                    height: rSize(20),
                  ),
                  renderAddress(),
                  SizedBox(
                    height: rSize(30),
                  ),
                  renderSocialMedia(),
                  SizedBox(
                    height: rSize(30),
                  ),
                  renderDescription(),
                  SizedBox(
                    height: rSize(30),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
