import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_loading-indicator.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      imagePath: 'assets/images/background4.png',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('assets/images/main_logo.png'),
              width: rSize(250),
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: rSize(40),
            ),
            CustomLoadingIndicator(
              customLoadingIndicatorProps: CustomLoadingIndicatorProps(
                containerSize: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
