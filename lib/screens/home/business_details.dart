import 'package:appointments/utils/data_types.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:appointments/widget/image_picker_modal.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/layout.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class BusinessDetails extends StatefulWidget {
  const BusinessDetails({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BusinessDetailsState();
  }
}

class BusinessDetailsState extends State<BusinessDetails> {
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
          Text(
            'Social Media',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
                ),
          ),
          SizedBox(
            height: rSize(10),
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
                      containerSize: rSize(30),
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
                      containerSize: rSize(30),
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
                      containerSize: rSize(30),
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

    Widget _renderBusinessLogo() {
      return EaseInAnimation(
        onTap: () => {
          showImagePickerModal(
            imagePickerModalProps: ImagePickerModalProps(
              context: context,
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
              width: double.infinity,
              height: rSize(200),
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
                      containerSize: rSize(90),
                    ),
                  ),
                  SizedBox(
                    height: rSize(2),
                  ),
                  Text(
                    'Add Cover Photo',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontSize: rSize(16),
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _renderDescription() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Business Description',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
                ),
          ),
          SizedBox(
            height: rSize(5),
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
          Text(
            'Email Address',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
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

    Widget _renderPhoneNumber() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Phone Number',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
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

    Widget _renderBusinessName() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Business Name',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
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
            titleText: 'Business Details',
            withBack: true,
            withSearch: false,
            withClipPath: false,
            customIcon: Icon(
              FontAwesomeIcons.floppyDisk,
              size: rSize(24),
            ),
            customIconTap: () => {Navigator.pushNamed(context, '/newService')},
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
            vertical: rSize(40),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAvatar(
                    customAvatarProps: CustomAvatarProps(
                      editable: true,
                      radius: rSize(130),
                      circleShape: true,
                      enable: true,
                      onTap: () => {
                        showImagePickerModal(
                          imagePickerModalProps: ImagePickerModalProps(
                            context: context,
                          ),
                        ),
                      },
                    ),
                  ),
                  SizedBox(
                    width: rSize(30),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        _renderBusinessName(),
                        SizedBox(
                          height: rSize(20),
                        ),
                        _renderPhoneNumber(),
                        SizedBox(
                          height: rSize(20),
                        ),
                      ],
                    ),
                  ),
                ],
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
              _renderBusinessLogo(),
            ],
          ),
        ),
      ),
    );
  }
}
