import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InternetConnectionScreen extends StatefulWidget {
  const InternetConnectionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return InternetConnectionScreenState();
  }
}

class InternetConnectionScreenState extends State<InternetConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      imagePath: 'assets/images/background4.png',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(
            left: rSize(30),
            right: rSize(30),
            top: rSize(200),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/images/no_internet.json',
                  repeat: true,
                  width: rSize(300),
                  animate: true,
                ),
                Text(
                  'Oooops!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: rSize(30),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: rSize(20),
                ),
                Text(
                  'No internet connection.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: rSize(16),
                      ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Please check your internet settings.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: rSize(16),
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
