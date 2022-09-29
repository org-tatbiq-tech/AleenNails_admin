import 'package:appointments/providers/settings_mgr.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/utils/validations.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController _wazeController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _webController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);

    _nameController.text = settingsMgr.profileManagement.businessInfo.name;
    _phoneController.text = settingsMgr.profileManagement.businessInfo.phone;
    _emailController.text = settingsMgr.profileManagement.businessInfo.email;
    _addressController.text =
        settingsMgr.profileManagement.businessInfo.address;
    _wazeController.text =
        settingsMgr.profileManagement.businessInfo.wazeAddressUrl!;
    _facebookController.text =
        settingsMgr.profileManagement.businessInfo.facebookUrl!;
    _instagramController.text =
        settingsMgr.profileManagement.businessInfo.instagramUrl!;
    _webController.text =
        settingsMgr.profileManagement.businessInfo.websiteUrl!;
    _descriptionController.text =
        settingsMgr.profileManagement.businessInfo.description!;

    _nameController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _addressController.addListener(() => setState(() {}));
    _wazeController.addListener(() => setState(() {}));
    _facebookController.addListener(() => setState(() {}));
    _instagramController.addListener(() => setState(() {}));
    _webController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _wazeController.dispose();
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
              'Social Media',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _facebookController,
              hintText: 'Facebook',
              keyboardType: TextInputType.text,
              validator: validateUrl,
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
              hintText: 'Instagram',
              keyboardType: TextInputType.text,
              validator: validateUrl,
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
              hintText: 'Website',
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
              'Business Description',
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
                hintText: 'Short description of your business (recommended)',
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
              'Email Address',
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
              'Address',
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
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _wazeController,
              hintText: 'Waze',
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
                      path: 'assets/icons/waze.png',
                      backgroundColor: Colors.transparent,
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
                ],
              ),
            ),
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
              'Phone Number',
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
              'Business Name',
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

    saveBusinessInfo() {
      final form = _formKey.currentState;
      if (form!.validate()) {
        final settingsMgr = Provider.of<SettingsMgr>(context, listen: false);
        settingsMgr.profileManagement.businessInfo.name = _nameController.text;
        settingsMgr.profileManagement.businessInfo.phone =
            _phoneController.text;
        settingsMgr.profileManagement.businessInfo.email =
            _emailController.text;
        settingsMgr.profileManagement.businessInfo.description =
            _descriptionController.text;
        settingsMgr.profileManagement.businessInfo.wazeAddressUrl =
            _wazeController.text;
        settingsMgr.profileManagement.businessInfo.facebookUrl =
            _facebookController.text;
        settingsMgr.profileManagement.businessInfo.instagramUrl =
            _instagramController.text;
        settingsMgr.profileManagement.businessInfo.websiteUrl =
            _webController.text;

        settingsMgr.submitNewProfile();
        showSuccessFlash(
          context: context,
          successColor: successPrimaryColor,
          successBody: 'Success!',
          successTitle: 'Data Updated Successfully.',
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
      child: Scaffold(
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: 'Business Name & Info',
            barHeight: 110,
            withClipPath: true,
            withBack: true,
            withSave: true,
            saveTap: () => {saveBusinessInfo()},
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
            vertical: rSize(20),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }
}
