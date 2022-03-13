import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RoundedInputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String errorText;
  final TextEditingController controller;
  final bool isDescription;
  final bool isPassword;
  final bool isConfirmPassword;
  final bool isPasswordVisible;
  final dynamic togglePassword;
  final String passwordToConfirm;
  final dynamic validator;
  final IconData icon;
  final IconData prefixIcon;
  final bool withPrefixIcon;
  final dynamic keyboardType;

  // final ValueChanged<String> onChanged;

  getColor(context, {opacity = 1.0}) {
    if (errorText.isEmpty) {
      return Theme.of(context).colorScheme.primaryVariant.withOpacity(opacity);
    } else {
      return Theme.of(context).colorScheme.error.withOpacity(opacity);
    }
  }

  getSuffixIcon(context) {
    if (controller.text.isNotEmpty) {
      if (isPassword) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              iconSize: 2.h,
              color: getColor(context),
              onPressed: () => controller.clear(),
              constraints: const BoxConstraints(),
              padding: EdgeInsets.fromLTRB(0, 0, 1.w, 0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.fromLTRB(0, 0, 3.w, 0),
              iconSize: 2.h,
              icon: Icon(
                  isPasswordVisible ? Icons.visibility_off : Icons.visibility),
              color: getColor(context),
              onPressed: () => togglePassword(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ],
        );
      } else {
        return IconButton(
          icon: const Icon(Icons.close),
          iconSize: 2.h,
          color: getColor(context),
          onPressed: () => controller.clear(),
          constraints: const BoxConstraints(),
          padding: EdgeInsets.fromLTRB(0, 0, 3.w, 0),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        );
      }
    } else {
      if (isPassword) {
        return IconButton(
          icon:
              Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
          iconSize: 2.h,
          color: getColor(context),
          onPressed: () => togglePassword(),
          constraints: const BoxConstraints(),
          padding: EdgeInsets.fromLTRB(0, 0, 3.w, 0),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        );
      } else {
        return null;
      }
    }
  }

  const RoundedInputField({
    Key? key,
    required this.controller,
    this.labelText = '',
    this.hintText = '',
    this.errorText = '',
    this.prefixIcon = Icons.person,
    this.icon = Icons.person,
    this.keyboardType = TextInputType.text,
    this.withPrefixIcon = false,
    this.isPassword = false,
    this.isConfirmPassword = false,
    this.isPasswordVisible = false,
    this.isDescription = false,
    this.passwordToConfirm = '',
    this.togglePassword,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.w),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 12.sp),
        maxLines: isDescription ? 5 : 1,
        keyboardType: keyboardType,
        validator: isConfirmPassword
            ? (value) => validator(value, passwordToConfirm)
            : (value) => validator(context, value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(2.h, 2.h, 4.h, 1.h),
          filled: true,
          floatingLabelBehavior: isDescription
              ? FloatingLabelBehavior.never
              : FloatingLabelBehavior.auto,
          fillColor: Theme.of(context).colorScheme.background.withOpacity(0.3),
          errorStyle: TextStyle(fontSize: 9.sp),
          suffixIcon: getSuffixIcon(context),
          prefixIcon: withPrefixIcon
              ? Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimary,
                )
              : null,
          hintText: hintText,
          isDense: false,
          labelText: isDescription ? null : labelText,
          hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontSize: 10.sp,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5)),
          floatingLabelStyle: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontSize: 12.sp, color: getColor(context)),
          labelStyle:
              Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12.sp),
          errorMaxLines: 1,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1.5.h),
              borderSide: BorderSide(color: Colors.red, width: 0.2.w)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1.5.h),
              borderSide: BorderSide(color: Colors.red, width: 0.3.w)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1.5.h),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  width: 0.3.w)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1.5.h),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 0.2.w)),
        ),
      ),
    );
  }
}
