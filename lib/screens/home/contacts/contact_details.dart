import 'dart:math';

import 'package:appointments/animations/fade_animation.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/utils/url_launch.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:appointments/widget/read_more_text.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Contact contact = Contact(
      name: 'Saeed',
      phone: '0543103540',
      address: 'Haifa',
    );
    List<Contact> contacts = [
      contact,
      contact,
      contact,
      contact,
      contact,
      contact
    ];

    Widget getAppointmentCard(BuildContext context, Contact contact) {
      return Card(
        margin: EdgeInsets.fromLTRB(0, 0, 0, rSize(20)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            rSize(15),
          ),
        ),
        child: ListTile(
          minLeadingWidth: rSize(40),
          minVerticalPadding: rSize(14),
          onTap: () => {},
          contentPadding: EdgeInsets.symmetric(
            vertical: rSize(0),
            horizontal: rSize(20),
          ),
          horizontalTitleGap: rSize(10),
          subtitle: Text(
            contact.phone!,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontSize: rSize(16)),
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconTheme(
                data: Theme.of(context).primaryIconTheme,
                child: Icon(
                  Icons.chevron_right,
                  size: rSize(25),
                ),
              ),
            ],
          ),
          leading: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAvatar(
                customAvatarProps: CustomAvatarProps(
                  radius: rSize(30),
                  rectangleShape: true,
                ),
              ),
            ],
          ),
          title: Text(
            contact.name!,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: rSize(20),
                ),
          ),
        ),
      );
    }

    _renderAppointments() {
      return SafeArea(
        left: false,
        right: false,
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeAnimation(
              positionType: PositionType.right,
              delay: 0.9,
              child: Text(
                'Appointments',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: rSize(18),
                    ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    top: rSize(20),
                    left: rSize(20),
                    right: rSize(20),
                  ),
                  itemCount: min(contacts.length, 3),
                  itemBuilder: (context, index) {
                    return FadeAnimation(
                        positionType: PositionType.top,
                        delay: 1 + index.toDouble() * 0.3,
                        child: getAppointmentCard(context, contacts[index]));
                  },
                ),
                CustomTextButton(
                  customTextButtonProps: CustomTextButtonProps(
                    onTap: () => {},
                    text: 'Show All',
                    textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: rSize(18),
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    _renderBirthday() {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Birthday',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
                ),
          ),
          SizedBox(
            height: rSize(5),
          ),
          Text(
            'Thursday 25-06-2020',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    }

    _renderLastVisiting() {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last Visiting',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
                ),
          ),
          SizedBox(
            height: rSize(5),
          ),
          Text(
            'Thursday 25-06-2020',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    }

    _renderNotes() {
      return Column(children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notes',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: rSize(18),
                  ),
            ),
            SizedBox(
              height: rSize(5),
            ),
            const ReadMoreText(
              'No notes was added dsakj dsakldsa sdjlkada sdjksladjas sdkasldjasld dsakdjsakldasjkldjasldjaslkdjlksadjalksdjalskjkldsjaklsdjklsdajlkdjas daskdjsadas ddkjsakljdklas dsakjdaskljd',
              trimLines: 2,
            ),
          ],
        ),
      ]);
    }

    _renderStatics() {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          borderRadius: BorderRadius.circular(
            rSize(20),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: rSize(20),
        ),
        height: rSize(60),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: rSize(4),
              direction: Axis.vertical,
              children: [
                Text(
                  'Bookings',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: rSize(18),
                      ),
                ),
                Text(
                  '1',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            VerticalDivider(
              endIndent: rSize(10),
              indent: rSize(10),
              thickness: rSize(1),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: rSize(4),
              direction: Axis.vertical,
              children: [
                Text(
                  'Finished',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: rSize(18),
                      ),
                ),
                Text(
                  '1',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            VerticalDivider(
              endIndent: rSize(10),
              indent: rSize(10),
              thickness: rSize(1),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: rSize(4),
              direction: Axis.vertical,
              children: [
                Text(
                  'Cancelled',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: rSize(18),
                      ),
                ),
                Text(
                  '1',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            VerticalDivider(
              endIndent: rSize(10),
              indent: rSize(10),
              thickness: rSize(1),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: rSize(4),
              direction: Axis.vertical,
              children: [
                Text(
                  'No-show',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: rSize(18),
                      ),
                ),
                Text(
                  '1',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    _renderHeader() {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeAnimation(
            delay: 0.1,
            child: CustomAvatar(
              customAvatarProps: CustomAvatarProps(
                radius: rSize(100),
                rectangleShape: false,
                circleShape: true,
                enable: false,
                isMale: false,
              ),
            ),
          ),
          SizedBox(
            width: rSize(20),
          ),
          FadeAnimation(
            delay: 0.1,
            positionType: PositionType.left,
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              spacing: rSize(2),
              runSpacing: rSize(2),
              children: [
                Text(
                  'Ahmad Manaa',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  '0505800955',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  'ahmadmnaa.b@gmail.com',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ],
      );
    }

    _renderActions() {
      return Row(
        children: [
          SizedBox(
            width: rSize(120),
          ),
          EaseInAnimation(
            onTap: () => makePhoneCall('0505800955'),
            child: CustomIcon(
              customIconProps: CustomIconProps(
                icon: Icon(
                  Icons.phone,
                  size: rSize(24),
                ),
              ),
            ),
          ),
          SizedBox(
            width: rSize(10),
          ),
          EaseInAnimation(
            onTap: () => sendSms('0505800955'),
            child: CustomIcon(
              customIconProps: CustomIconProps(
                icon: Icon(
                  Icons.message,
                  size: rSize(24),
                ),
              ),
            ),
          ),
          SizedBox(
            width: rSize(10),
          ),
          EaseInAnimation(
            onTap: () => sendMail('ahmadmnaa.b@gmail.com'),
            child: CustomIcon(
              customIconProps: CustomIconProps(
                icon: Icon(
                  Icons.email,
                  size: rSize(24),
                ),
              ),
            ),
          ),
          SizedBox(
            width: rSize(10),
          ),
          EaseInAnimation(
            onTap: () => {Navigator.pushNamed(context, '/newAppointment')},
            child: CustomIcon(
              customIconProps: CustomIconProps(
                withPadding: true,
                path: 'assets/icons/calendar_plus.png',
                icon: null,
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Contact Details',
          withBack: true,
          barHeight: 120,
          withClipPath: true,
          customIcon: Icon(
            Icons.edit,
            size: rSize(24),
          ),
          customIconTap: () => {},
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: rSize(20),
            ),
            child: Column(
              children: [
                _renderHeader(),
                FadeAnimation(
                  positionType: PositionType.bottom,
                  delay: 0.4,
                  child: _renderActions(),
                ),
                SizedBox(
                  height: rSize(24),
                ),
                FadeAnimation(
                  positionType: PositionType.top,
                  delay: 0.5,
                  child: _renderStatics(),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(
                horizontal: rSize(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: rSize(30),
                  ),
                  FadeAnimation(
                    positionType: PositionType.right,
                    delay: 0.6,
                    child: _renderBirthday(),
                  ),
                  SizedBox(
                    height: rSize(24),
                  ),
                  FadeAnimation(
                    positionType: PositionType.right,
                    delay: 0.7,
                    child: _renderLastVisiting(),
                  ),
                  SizedBox(
                    height: rSize(24),
                  ),
                  FadeAnimation(
                    positionType: PositionType.right,
                    delay: 0.8,
                    child: _renderNotes(),
                  ),
                  SizedBox(
                    height: rSize(40),
                  ),
                  _renderAppointments(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
