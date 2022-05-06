import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:flutter/material.dart';

class CustomStatus extends StatelessWidget {
  CustomStatusProps customStatusProps;
  CustomStatus({
    Key? key,
    required this.customStatusProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getStatusColor() {
      switch (customStatusProps.status) {
        case Status.confirmed:
          return Colors.green;
        case Status.cancelled:
          return Colors.red;
        case Status.declined:
          return Colors.red;
        case Status.waiting:
          return Colors.orange;
        default:
          return Colors.orange;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: lighten(
          _getStatusColor(),
          0.3,
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
                color: _getStatusColor(),
              ),
        ),
      ),
    );
  }
}
