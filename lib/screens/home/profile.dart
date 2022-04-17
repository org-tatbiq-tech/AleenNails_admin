import 'package:appointments/animations/fade_animation.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_icon_button.dart';
import 'package:appointments/widget/custom_modal.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:appointments/widget/picker_time_range_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import '../../utils/data_types.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TimePickerSpinner(
            //   spacing: rSize(30),
            //   highlightedTextStyle: Theme.of(context)
            //       .textTheme
            //       .headline1
            //       ?.copyWith(
            //           fontSize: rSize(24),
            //           color: Theme.of(context).colorScheme.primary),
            //   normalTextStyle: Theme.of(context).textTheme.headline1?.copyWith(
            //         fontSize: rSize(24),
            //       ),
            //   is24HourMode: true,
            //   alignment: Alignment.bottomCenter,
            //   itemHeight: rSize(60),
            //   itemWidth: rSize(40),
            //   minutesInterval: 5,
            //   onTimeChange: (time) {
            //     setState(() {
            //       // _dateTime = time;
            //     });
            //   },
            // ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                  onTap: () => {},
                  animationDelay: 0.1,
                  iconPath: 'assets/icons/growth.png',
                  positionType: PositionType.bottom,
                  text: 'Marketing'),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                  onTap: () => {},
                  animationDelay: 0.3,
                  iconPath: 'assets/icons/rating.png',
                  positionType: PositionType.bottom,
                  text: 'Reviews & Ratings'),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                  onTap: () => {},
                  animationDelay: 0.5,
                  iconPath: 'assets/icons/profile.png',
                  positionType: PositionType.bottom,
                  text: 'Profile'),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                  onTap: () => {},
                  animationDelay: 0.7,
                  iconPath: 'assets/icons/settings.png',
                  positionType: PositionType.bottom,
                  text: 'Settings'),
            ),
            SizedBox(
              height: rSize(20),
            ),
            CustomIconButton(
              customIconButtonProps: CustomIconButtonProps(
                onTap: () => {
                  showPickerTimeRangeModal(
                    PickerTimeRangeModalProps(
                      context: context,
                      startTimeLabel: 'Start Time',
                      endTimeLabel: 'End Time',
                      title: 'Select Time',
                      pickerTimeRangType: PickerTimeRangType.range,
                      primaryAction: () => {
                        print('ahshdaskldaslkdkdlasdaslk'),
                      },
                    ),
                  ),
                },
                animationDelay: 0.9,
                iconPath: 'assets/icons/customer-support.png',
                positionType: PositionType.bottom,
                text: 'Customer Support Chat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
