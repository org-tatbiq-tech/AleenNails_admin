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
        case Status.approved:
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
          rSize(10),
        ),
        boxShadow: [
          BoxShadow(),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(15),
          vertical: rSize(6),
        ),
        child: Text(
          customStatusProps.status.name.toUpperCase(),
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: rSize(18),
                color: _getStatusColor(),
              ),
        ),
      ),
    );
  }
}
