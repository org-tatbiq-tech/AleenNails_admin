import 'package:appointments/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    content: SizedBox(
      width: rSize(120),
      height: rSize(120),
      child: LoadingIndicator(
          indicatorType: Indicator.ballScaleMultiple,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primary,
          ],
          backgroundColor: Colors.transparent,
          pathBackgroundColor: Colors.transparent),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
