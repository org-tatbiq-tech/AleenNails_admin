import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CalendarEvent {
  final String title;
  const CalendarEvent(this.title);
  @override
  String toString() => title;
}

enum ModalFooter { primaryButton, secondaryButton, both, none }

class LiquidSwipeData {
  final Color gradientStart;
  final Color gradientEnd;
  final String image;
  final String text1;
  final String text2;
  final String text3;

  LiquidSwipeData({
    this.gradientStart = Colors.white,
    this.gradientEnd = Colors.white,
    required this.image,
    this.text1 = '',
    this.text2 = '',
    this.text3 = '',
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

class CustomAppBarProps {
  final String titleText;
  final Widget? titleWidget;
  final bool centerTitle;
  final Widget? customIcon;
  final bool withSearch;
  final Widget? leadingWidget;
  CustomAppBarProps(
      {this.titleText = 'Custom Title',
      this.titleWidget,
      this.centerTitle = true,
      this.customIcon,
      this.leadingWidget,
      this.withSearch = false});
}

class CustomButtonProps {
  final String text;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool capitalizeText;
  final Color backgroundColor;
  final Color textColor;
  final bool isSecondary;
  CustomButtonProps({
    this.text = '',
    this.isPrimary = true,
    this.isSecondary = false,
    this.capitalizeText = true,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
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
