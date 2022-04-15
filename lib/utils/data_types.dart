import 'package:flutter/material.dart';
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
  final CalendarFormat calendarFormat;
  List<CalendarEvent> Function(DateTime)? eventLoader;
  void Function(DateTime, DateTime)? onDaySelected;
  void Function(CalendarFormat)? onFormatChanged;
  void Function(DateTime)? onPageChanged;
  ExpandableCalendarProps({
    required this.focusedDay,
    this.selectedDay,
    required this.calendarFormat,
    this.eventLoader,
    this.onDaySelected,
    this.onFormatChanged,
    this.onPageChanged,
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
  String? name;
  String? duration;
  double? price;
  String? notes;

  Service({
    this.name,
    this.duration,
    this.price,
    this.notes,
  });
}

enum Status {
  approved,
  declined,
  cancelled,
  waiting,
}

class CustomStatusProps {
  Status status;
  CustomStatusProps({
    required this.status,
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

  ServiceCardProps({
    required this.serviceDetails,
    this.withNavigation = true,
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

class CustomIconProps {
  final Widget? icon;
  final Color? backgroundColor;
  final double containerSize;
  final String path;
  final Color? iconColor;
  final bool withPadding;

  CustomIconProps({
    required this.icon,
    this.backgroundColor,
    this.containerSize = 40,
    this.path = '',
    this.iconColor,
    this.withPadding = false,
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
  final Icon? customIcon;
  final VoidCallback? customIconTap;
  final bool withSearch;
  final bool withBack;
  final bool withClipPath;
  final bool withBorder;
  final double barHeight;
  CustomAppBarProps({
    this.titleText = 'Custom Title',
    this.titleWidget,
    this.barHeight = 60,
    this.centerTitle = WrapAlignment.center,
    this.customIcon,
    this.customIconTap,
    this.withBack = false,
    this.withSearch = false,
    this.withClipPath = false,
    this.withBorder = false,
  });
}

class CustomButtonProps {
  final String text;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool capitalizeText;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isSecondary;
  CustomButtonProps({
    this.text = '',
    this.isPrimary = true,
    this.isSecondary = false,
    this.capitalizeText = true,
    this.backgroundColor,
    this.textColor,
    required this.onTap,
  });
}

class CustomInputFieldProps {
  final String labelText;
  final String hintText;
  final String errorText;
  final TextEditingController controller;
  final bool isDescription;
  final int? maxLength;
  final bool isPassword;
  final bool isConfirmPassword;
  final bool isPasswordVisible;
  final bool isSearch;
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
    this.icon = Icons.person,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isSearch = false,
    this.isConfirmPassword = false,
    this.isPasswordVisible = false,
    this.isDescription = false,
    this.passwordToConfirm = '',
    this.togglePassword,
    this.validator,
  });
}

class BottomModalProps {
  BuildContext context;
  Widget child;
  bool isDismissible;
  bool enableDrag;
  bool showDragPen;
  ModalFooter footerButton;
  String title;
  String primaryButtonText;
  String secondaryButtonText;
  bool centerTitle;
  Duration duration;

  BottomModalProps(
      {required this.context,
      required this.child,
      this.isDismissible = true,
      this.enableDrag = false,
      this.showDragPen = false,
      this.title = 'Header Title',
      this.primaryButtonText = 'primary',
      this.secondaryButtonText = 'secondary',
      this.centerTitle = false,
      this.duration = const Duration(milliseconds: 350),
      this.footerButton = ModalFooter.none});
}
