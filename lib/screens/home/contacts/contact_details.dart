import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:flutter/material.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
            leadingWidget: true,
            centerTitle: true,
            titleText: 'Client Details'),
      ),
      body: Center(
          child: CustomAvatar(
        customAvatarProps: CustomAvatarProps(radius: 100),
      )),
    );
  }
}
