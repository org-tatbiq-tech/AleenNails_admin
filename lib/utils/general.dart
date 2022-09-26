import 'package:appointments/data_types/macros.dart';

import 'layout.dart';

getStatusColor(Status status) {
  switch (status) {
    case Status.confirmed:
      return successPrimaryColor;
    case Status.cancelled:
      return errorPrimaryColor;
    case Status.declined:
      return errorPrimaryColor;
    case Status.waiting:
      return warningPrimaryColor;
    default:
      return informationPrimaryColor;
  }
}
