import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/course.dart';
import 'package:appointments/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/*
Package details shows all needed information on Package once clicked

*/

class CourseDetails extends StatefulWidget {
  const CourseDetails({Key? key}) : super(key: key);

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  Course tempCourse = Course('course1ID', 'course name', 10);

  Widget _getCourseName(BuildContext context, Course course) {
    return Wrap(
      children: [
        Icon(
          FontAwesomeIcons.peopleArrows,
          color: Theme.of(context).colorScheme.secondary,
          size: rSize(22),
        ),
        Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
              child: Text(
                Languages.of(context)!.labelCourseName + ':',
                style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: rSize(25)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
              child: Text(
                course.courseName,
                style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: rSize(22)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getCourseID(BuildContext context, Course course) {
    return Wrap(
      children: [
        Icon(
          FontAwesomeIcons.idCard,
          color: Theme.of(context).colorScheme.secondary,
          size: rSize(22),
        ),
        Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
              child: Text(
                Languages.of(context)!.labelCourseName + ':',
                style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: rSize(25)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
              child: Text(
                course.courseName,
                style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: rSize(22)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getCourseAttendees(BuildContext context, Course course) {
    return Wrap(
      children: [
        Icon(
          Icons.numbers,
          color: Theme.of(context).colorScheme.secondary,
          size: rSize(22),
        ),
        Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
              child: Text(
                Languages.of(context)!.labelCourseAttendees + ':',
                style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: rSize(25)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: rSize(10), vertical: rSize(5)),
              child: Text(
                course.attendees.toString(),
                style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: rSize(22)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildMainUI() {
    return CustomContainer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: rSize(20)),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              offset: const Offset(0, 0),
              blurRadius: 5,
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: rSize(20),
              ),
              Wrap(
                children: [
                  Text(
                    Languages.of(context)!.courseDetails,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
              _getCourseName(context, tempCourse),
              SizedBox(
                height: rSize(20),
              ),
              _getCourseID(context, tempCourse),
              SizedBox(
                height: rSize(20),
              ),
              _getCourseAttendees(context, tempCourse),
              SizedBox(
                height: rSize(20),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildMainUI();
  }
}
