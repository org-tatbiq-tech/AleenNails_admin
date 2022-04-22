import 'package:appointments/animations/fade_animation.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/custom_status.dart';
import 'package:appointments/widget/read_more_text.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/service_card.dart';
import 'package:flutter/material.dart';

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
            delay: 0.6,
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
                  delay: 0.8 + index.toDouble() * 0.3,
                  child: ServiceCard(
                    serviceCardProps:
                        ServiceCardProps(serviceDetails: services[index]),
                  ),
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
            FadeAnimation(
              delay: 0.3,
              positionType: PositionType.right,
              child: IconTheme(
                data: Theme.of(context).primaryIconTheme,
                child: CustomIcon(
                  customIconProps: CustomIconProps(
                    backgroundColor: Colors.transparent,
                    path: 'assets/icons/calendar_time.png',
                    icon: null,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: rSize(10),
            ),
            FadeAnimation(
              delay: 0.3,
              positionType: PositionType.left,
              child: Column(
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
                enable: true,
                onTap: () => {
                  Navigator.pushNamed(context, '/contactDetails'),
                },
                circleShape: true,
                isMale: false,
              ),
            ),
          ),
          SizedBox(
            width: rSize(20),
          ),
          Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.center,
            spacing: rSize(2),
            runSpacing: rSize(2),
            children: [
              FadeAnimation(
                delay: 0.1,
                positionType: PositionType.left,
                child: Text(
                  'Ahmad Manaa',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              FadeAnimation(
                delay: 0.1,
                positionType: PositionType.left,
                child: Text(
                  '0505800955',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(
                height: rSize(10),
              ),
              _renderDate(),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Appointment Details',
          withBack: true,
          barHeight: 110,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeAnimation(
            positionType: PositionType.bottom,
            delay: 0.3,
            child: CustomStatus(
              customStatusProps: CustomStatusProps(status: Status.waiting),
            ),
          ),
          SizedBox(
            height: rSize(10),
          ),
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
                    delay: 0.5,
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
