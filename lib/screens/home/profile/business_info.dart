import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _webController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
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
    _facebookController.dispose();
    _instagramController.dispose();
    _webController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _renderSocialMedia() {
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

    Widget _renderDescription() {
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

    Widget _renderEmail() {
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
            ),
          ),
        ],
      );
    }

    Widget _renderPhoneNumber() {
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
              controller: _phoneController,
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      );
    }

    Widget _renderBusinessName() {
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
            ),
          ),
        ],
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
            titleText: 'Business Name & Info',
            barHeight: 110,
            withClipPath: true,
            withBack: true,
            withSave: true,
            saveTap: () => {},
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
            vertical: rSize(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _renderBusinessName(),
              SizedBox(
                height: rSize(20),
              ),
              _renderPhoneNumber(),
              SizedBox(
                height: rSize(20),
              ),
              _renderEmail(),
              SizedBox(
                height: rSize(30),
              ),
              _renderSocialMedia(),
              SizedBox(
                height: rSize(30),
              ),
              _renderDescription(),
              SizedBox(
                height: rSize(30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
