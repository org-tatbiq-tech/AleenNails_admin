import 'package:flutter/material.dart';

class CalendarEvent {
  final String title;
  const CalendarEvent(this.title);
  @override
  String toString() => title;
}

enum ModalFooter { primaryButton, secondaryButton, both, none }

class CustomButtonProps {
  final String text;
  final VoidCallback onTap;
  final bool isPrimary;
  final Color backgroundColor;
  final bool isSecondary;
  CustomButtonProps({
    this.text = '',
    this.isPrimary = false,
    this.isSecondary = false,
    this.backgroundColor = Colors.white,
    required this.onTap,
  });
}

class CustomInputFieldProps {
  final String labelText;
  final String hintText;
  final String errorText;
  final TextEditingController controller;
  final bool isDescription;
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
