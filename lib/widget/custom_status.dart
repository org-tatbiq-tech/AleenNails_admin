import 'package:appointments/data_types/macros.dart';
import 'package:appointments/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';

class CustomStatus extends StatelessWidget {
  final CustomStatusProps customStatusProps;
  const CustomStatus({
    Key? key,
    required this.customStatusProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lighten(
          getStatusColor(customStatusProps.status),
          0.22,
        ),
        borderRadius: BorderRadius.circular(
          rSize(customStatusProps.fontSize / 1.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(customStatusProps.fontSize / 1.1),
          vertical: rSize(customStatusProps.fontSize / 2),
        ),
        child: Text(
          customStatusProps.status.name.toUpperCase(),
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: rSize(customStatusProps.fontSize),
                color: getStatusColor(customStatusProps.status),
              ),
        ),
      ),
    );
  }
}

class CustomStatusProps {
  Status status;
  double fontSize;
  CustomStatusProps({
    required this.status,
    this.fontSize = 16,
  });
}
