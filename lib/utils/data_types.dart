import 'dart:io';

import 'package:appointments/animations/fade_animation.dart';
import 'package:appointments/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

// TODO: Ahmad add documentation in each of the classed below
// Where it is used and how ?
/// Add documentation here - general documentation
/// ...

class CalendarEvent {
  /// Add documentation here
  /// ...

  final String title;
  const CalendarEvent(this.title);
  @override
  String toString() => title;
}

enum ModalFooter {
  primaryButton,
  secondaryButton,
  both,
  none,
}

class LiquidSwipeData {
  /// Add documentation here
  /// ...
  /// Please don't use text1/text2/..., use meaningful names
  final Color gradientStart;
  final Color gradientEnd;
  final String image;
  final String title;
  final String subTitle;
  final String description;

  LiquidSwipeData({
    this.gradientStart = Colors.white,
    this.gradientEnd = Colors.white,
    required this.image,
    this.title = '',
    this.subTitle = '',
    this.description = '',
  });
}

class ExpandableCalendarProps {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final CalendarFormat calendarFormat;
  final Map<CalendarFormat, String>? availableCalendarFormats;
  List<CalendarEvent> Function(DateTime)? eventLoader;
  void Function(DateTime, DateTime)? onDaySelected;
  void Function(CalendarFormat)? onFormatChanged;
  void Function(DateTime)? onPageChanged;
  final bool formatButtonVisible;
  ExpandableCalendarProps({
    required this.focusedDay,
    this.selectedDay,
    this.firstDay,
    this.lastDay,
    required this.calendarFormat,
    this.eventLoader,
    this.onDaySelected,
    this.onFormatChanged,
    this.onPageChanged,
    this.availableCalendarFormats,
    this.formatButtonVisible = true,
  });
}

class CustomTextButtonProps {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final Icon icon;
  final bool withIcon;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  CustomTextButtonProps({
    this.text = '',
    this.textColor,
    this.fontSize,
    this.withIcon = false,
    this.textStyle,
    this.icon = const Icon(
      FontAwesomeIcons.plus,
      color: Colors.green,
      size: 3,
    ),
    required this.onTap,
  });
}

class WorkingDay {
  String title;
  String subTitle;
  DateTime? selectedDate;
  DateTime startTime;
  DateTime endTime;
  bool isDayOff;

  WorkingDay({
    required this.title,
    this.subTitle = '',
    required this.startTime,
    required this.endTime,
    this.selectedDate,
    this.isDayOff = true,
  });
}

class Contact {
  String? name;
  String? phone;
  String? address;

  Contact({
    this.name,
    this.phone,
    this.address,
  });
}

class Service {
  String? id;
  String? name;
  String? duration;
  DateTime? startTime;
  DateTime? endTime;
  double? price;
  String? notes;
  Color? color;
  bool createdByBusiness;

  Service({
    this.id,
    this.name,
    this.duration,
    this.startTime,
    this.endTime,
    this.price,
    this.notes,
    this.color,
    this.createdByBusiness = false,
  });
}

enum Status {
  confirmed,
  declined,
  cancelled,
  waiting,
}

class CustomStatusProps {
  Status status;
  double fontSize;
  CustomStatusProps({
    required this.status,
    this.fontSize = 16,
  });
}

class CustomAccordionSectionProps {
  final Widget header;
  final Widget content;

  CustomAccordionSectionProps({
    required this.header,
    required this.content,
  });
}

class ServiceCardProps {
  final Service serviceDetails;
  final bool withNavigation;
  final bool enabled;
  final String subTitle;
  final String title;
  final Function? onTap;

  ServiceCardProps({
    required this.serviceDetails,
    this.withNavigation = true,
    this.enabled = true,
    this.subTitle = '',
    this.title = '',
    this.onTap,
  });
}

class ContactCardProps {
  final Contact contactDetails;
  final bool withNavigation;

  ContactCardProps({
    required this.contactDetails,
    this.withNavigation = true,
  });
}

class CustomListTileProps {
  final Widget? trailing;
  final Widget? leading;
  final Widget? title;
  final Widget? subTitle;
  final EdgeInsets? contentPadding;
  final bool enabled;
  final Function? onTap;
  final double? minLeadingWidth;
  final double? height;
  CustomListTileProps({
    this.trailing,
    this.leading,
    this.title,
    this.subTitle,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.minLeadingWidth,
    this.height,
  });
}

class CustomSlidableProps {
  final String groupTag;
  final Widget child;
  final Function? deleteAction;
  ValueKey key;
  CustomSlidableProps({
    this.groupTag = 'groupTag',
    required this.child,
    this.deleteAction,
    this.key = const ValueKey(0),
  });
}

class CustomIconProps {
  final Widget? icon;
  final Color? backgroundColor;
  final double containerSize;
  final String path;
  final Color? iconColor;
  final Color? borderColor;
  final bool withPadding;
  final double? contentPadding;
  CustomIconProps({
    required this.icon,
    this.backgroundColor,
    this.containerSize = 40,
    this.path = '',
    this.iconColor,
    this.borderColor,
    this.withPadding = false,
    this.contentPadding,
  });
}

class CustomAvatarProps {
  final double radius;
  final bool enable;
  final bool circleShape;
  final bool rectangleShape;
  final bool isMale;
  final bool editable;
  final ImageProvider backgroundImage;
  final Function? onTap;

  CustomAvatarProps({
    this.radius = 50,
    this.enable = false,
    this.isMale = false,
    this.editable = false,
    this.circleShape = false,
    this.onTap,
    this.rectangleShape = false,
    this.backgroundImage = const AssetImage('assets/images/avatar_female.png'),
  });
}

class CustomSilverAppBarProps {
  final double expandedHeight;
  final double safeAreaHeight;
  final String titleText;
  final Widget? titleWidget;
  final bool centerTitle;
  final Widget? customIcon;
  final bool withBack;
  CustomSilverAppBarProps({
    required this.expandedHeight,
    required this.safeAreaHeight,
    this.titleText = 'Custom Title',
    this.titleWidget,
    this.centerTitle = true,
    this.customIcon,
    this.withBack = false,
  });
}

class CustomAppBarProps {
  final String titleText;
  final Widget? titleWidget;
  final WrapAlignment centerTitle;
  final Widget? customIcon;
  final VoidCallback? customIconTap;
  final bool withSearch;
  final bool withBack;
  final bool withSave;
  final VoidCallback? saveTap;
  final bool withClipPath;
  final bool withBorder;
  final double barHeight;
  CustomAppBarProps({
    this.titleText = 'Custom Title',
    this.titleWidget,
    this.barHeight = 65,
    this.centerTitle = WrapAlignment.center,
    this.customIcon,
    this.customIconTap,
    this.saveTap,
    this.withBack = false,
    this.withSave = false,
    this.withSearch = false,
    this.withClipPath = false,
    this.withBorder = false,
  });
}

class CustomIconButtonProps {
  final String text;
  final String iconPath;
  final double animationDelay;
  final PositionType positionType;
  final VoidCallback onTap;
  CustomIconButtonProps({
    this.text = '',
    this.iconPath = 'assets/icons/calendar_plus.png',
    this.animationDelay = 0,
    this.positionType = PositionType.right,
    required this.onTap,
  });
}

class CustomButtonProps {
  final String text;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool isDisabled;
  final bool capitalizeText;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final bool isSecondary;
  final double beginAnimation;
  CustomButtonProps({
    this.text = '',
    this.isPrimary = true,
    this.isSecondary = false,
    this.capitalizeText = true,
    this.isDisabled = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.beginAnimation = 0.99,
    required this.onTap,
  });
}

class CustomInputFieldProps {
  final String labelText;
  final String hintText;
  final String errorText;
  final TextEditingController controller;
  List<TextInputFormatter>? inputFormatters;
  final bool isDescription;
  final int? maxLength;
  final bool isPassword;
  final bool isConfirmPassword;
  final bool isPasswordVisible;
  final bool isSearch;
  final bool isCurrency;
  final dynamic togglePassword;
  final String passwordToConfirm;
  final dynamic validator;
  final IconData icon;
  final Widget? prefixIcon;
  final dynamic keyboardType;
  CustomInputFieldProps({
    required this.controller,
    this.labelText = '',
    this.hintText = '',
    this.errorText = '',
    this.prefixIcon,
    this.maxLength,
    this.inputFormatters,
    this.icon = Icons.person,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isSearch = false,
    this.isConfirmPassword = false,
    this.isPasswordVisible = false,
    this.isCurrency = false,
    this.isDescription = false,
    this.passwordToConfirm = '',
    this.togglePassword,
    this.validator,
  });
}

class CustomImagePickerProps {
  bool isGallery;
  bool cropImage;
  CustomImagePickerProps({
    this.isGallery = true,
    this.cropImage = true,
  });
}

class BottomModalProps {
  BuildContext context;
  Widget child;
  bool isDismissible;
  bool deleteCancelModal;
  bool enableDrag;
  bool showDragPen;
  ModalFooter footerButton;
  String title;
  String primaryButtonText;
  String secondaryButtonText;
  bool centerTitle;
  Duration duration;
  Function? primaryAction;

  BottomModalProps({
    required this.context,
    required this.child,
    this.isDismissible = true,
    this.enableDrag = false,
    this.showDragPen = false,
    this.deleteCancelModal = false,
    this.title = '',
    this.primaryButtonText = 'primary',
    this.secondaryButtonText = 'secondary',
    this.centerTitle = false,
    this.duration = const Duration(milliseconds: 350),
    this.footerButton = ModalFooter.none,
    this.primaryAction,
  });
}

enum PickerTimeRangType {
  single,
  range,
}

class ImagePickerModalProps {
  BuildContext context;
  String title;
  ImagePickerModalProps({
    required this.context,
    this.title = '',
  });
}

class PickerTimeRangeModalProps {
  BuildContext context;
  DateTime? startTimeValue;
  String? minuteSuffix;
  String? hourSuffix;
  DateTime? endTimeValue;
  String startTimeLabel;
  String endTimeLabel;
  String title;
  DateTime? endTimeMinValue;
  PickerTimeRangType pickerTimeRangType;
  Function? primaryAction;

  PickerTimeRangeModalProps({
    required this.context,
    this.startTimeValue,
    this.endTimeValue,
    this.title = '',
    this.minuteSuffix,
    this.hourSuffix,
    this.startTimeLabel = '',
    this.endTimeLabel = '',
    this.pickerTimeRangType = PickerTimeRangType.single,
    this.endTimeMinValue,
    this.primaryAction,
  });
}

class WheelPickerModalProps {
  BuildContext context;
  String title;
  Function? primaryAction;
  List<dynamic> pickerData;

  WheelPickerModalProps({
    required this.context,
    this.title = '',
    required this.pickerData,
    this.primaryAction,
  });
}
