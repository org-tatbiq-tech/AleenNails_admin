import 'package:appointments/animations/fade_animation.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/utils/url_launch.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/read_more_text.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({Key? key}) : super(key: key);

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Service service = Service(
      name: 'Service Name',
      duration: '2 Hours',
      price: 25,
    );
    List<Service> services = [
      service,
      service,
    ];

    Widget getAppointmentCard(BuildContext context, Service service) {
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
            service.duration!,
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
            service.name!,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: rSize(20),
                ),
          ),
        ),
      );
    }

    _renderServices() {
      String servicesLength = services.length.toString();
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeAnimation(
            positionType: PositionType.right,
            delay: 0.9,
            child: Text(
              'Services ($servicesLength)',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: rSize(18),
                  ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              padding: EdgeInsets.only(
                top: rSize(20),
                left: rSize(20),
                right: rSize(20),
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return FadeAnimation(
                  positionType: PositionType.top,
                  delay: 1 + index.toDouble() * 0.3,
                  child: getAppointmentCard(context, services[index]),
                );
              },
            ),
          ),
        ],
      );
    }

    _renderDate() {
      return Column(children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconTheme(
              data: Theme.of(context).primaryIconTheme,
              child: CustomIcon(
                customIconProps: CustomIconProps(
                  backgroundColor: Colors.transparent,
                  path: 'assets/icons/calendar_time.png',
                  icon: null,
                ),
              ),
            ),
            SizedBox(
              width: rSize(10),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Wed 13/02/2022',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: rSize(18),
                      ),
                ),
                // SizedBox(
                //   height: rSize(2),
                // ),
                Text(
                  '13:00 - 14:30',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: rSize(16),
                      ),
                ),
              ],
            ),
          ],
        ),
      ]);
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
                radius: rSize(130),
                rectangleShape: false,
                circleShape: true,
                editable: false,
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
                SizedBox(
                  height: rSize(10),
                ),
                _renderDate(),
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
                icon: Icon(
                  FontAwesomeIcons.calendarPlus,
                  size: rSize(22),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Appointment Details',
          withBack: true,
          // withSearch: true,
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
            child: _renderHeader(),
          ),
          Expanded(
            child: Padding(
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
                    delay: 0.8,
                    child: _renderNotes(),
                  ),
                  SizedBox(
                    height: rSize(40),
                  ),
                  Expanded(
                    child: _renderServices(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
