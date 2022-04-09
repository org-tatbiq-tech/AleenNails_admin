import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/custom_expandable_text.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    _renderLastVisited() {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(20),
          vertical: rSize(10),
        ),
        child: Column(children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last Visited:',
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
          ),
        ]),
      );
    }

    _renderNotes() {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(20),
          vertical: rSize(10),
        ),
        child: Column(children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notes:',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: rSize(18),
                    ),
              ),
              SizedBox(
                height: rSize(5),
              ),
              ReadMoreText(
                'No notes was added dsakj dsakldsa sdjlkada sdjksladjas sdkasldjasld dsakdjsakldasjkldjasldjaslkdjlksadjalksdjalskjkldsjaklsdjklsdajlkdjas daskdjsadas ddkjsakljdklas dsakjdaskljd',
                trimLength: 100,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: rSize(18),
                    ),
              ),
            ],
          ),
        ]),
      );
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

    _renderActions() {
      return Row(
        children: [
          SizedBox(
            width: rSize(120),
          ),
          EaseInAnimation(
            onTap: () => {},
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
            onTap: () => {},
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
            onTap: () => {},
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
            onTap: () => {},
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
          titleText: 'Contact Details',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAvatar(
                  customAvatarProps: CustomAvatarProps(
                    radius: rSize(100),
                    rectangleShape: false,
                    circleShape: true,
                    editable: false,
                    isMale: false,
                  ),
                ),
                SizedBox(
                  width: rSize(20),
                ),
                Expanded(
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
            ),
            _renderActions(),
            SizedBox(
              height: rSize(24),
            ),
            _renderStatics(),
            SizedBox(
              height: rSize(24),
            ),
            _renderLastVisited(),
            // SizedBox(
            //   height: rSize(10),
            // ),
            _renderNotes(),
          ],
        ),
      ),
    );
  }

  Widget makeVideo({image}) {
    return AspectRatio(
      aspectRatio: 1.5 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.black.withOpacity(.9),
            Colors.black.withOpacity(.3)
          ])),
          child: Align(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 70,
            ),
          ),
        ),
      ),
    );
  }
}
