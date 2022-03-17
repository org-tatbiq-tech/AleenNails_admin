import 'package:appointments/utils/layout_util.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
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

  const CustomInputField({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getColor({opacity = 1.0}) {
      if (errorText.isEmpty) {
        return Theme.of(context).colorScheme.primary.withOpacity(opacity);
      } else {
        return Theme.of(context).colorScheme.error.withOpacity(opacity);
      }
    }

    getSuffixIcon() {
      if (controller.text.isNotEmpty) {
        if (isPassword) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconTheme(
                data: Theme.of(context).iconTheme,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  color: getColor(),
                  onPressed: () => controller.clear(),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.fromLTRB(0, 0, rSize(10), 0),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ),
              IconTheme(
                data: Theme.of(context).iconTheme,
                child: IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.fromLTRB(0, 0, rSize(10), 0),
                  icon: Icon(isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  color: getColor(),
                  onPressed: () => togglePassword(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ),
            ],
          );
        } else {
          return IconTheme(
            data: Theme.of(context).iconTheme,
            child: IconButton(
              icon: const Icon(Icons.close),
              color: getColor(),
              onPressed: () => controller.clear(),
              constraints: const BoxConstraints(),
              padding: EdgeInsets.fromLTRB(0, 0, rSize(10), 0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          );
        }
      } else {
        if (isPassword) {
          return IconTheme(
            data: Theme.of(context).iconTheme,
            child: IconButton(
              icon: Icon(
                  isPasswordVisible ? Icons.visibility_off : Icons.visibility),
              color: getColor(),
              onPressed: () => togglePassword(),
              constraints: const BoxConstraints(),
              padding: EdgeInsets.fromLTRB(0, 0, rSize(10), 0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          );
        } else {
          return null;
        }
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: isSearch ? 0 : rSize(18)),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        cursorColor: Theme.of(context).colorScheme.primary,
        style: Theme.of(context).textTheme.caption,
        maxLines: isDescription ? 5 : 1,
        keyboardType: keyboardType,
        validator: isConfirmPassword
            ? (value) => validator(value, passwordToConfirm)
            : (value) => validator(context, value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, rSize(6), 0, rSize(6)),
          filled: true,
          floatingLabelBehavior: isSearch
              ? FloatingLabelBehavior.never
              : FloatingLabelBehavior.auto,
          fillColor: Theme.of(context).colorScheme.background,
          errorStyle: TextStyle(fontSize: rSize(18)),
          suffixIcon: getSuffixIcon(),
          prefixIcon: !isSearch
              ? prefixIcon
              : IconTheme(
                  data: Theme.of(context).primaryIconTheme,
                  child: const Icon(
                    Icons.search,
                  ),
                ),
          hintText: hintText,
          isDense: false,
          labelText: isDescription ? null : labelText,
          hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontSize: rSize(18),
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5)),
          floatingLabelStyle: Theme.of(context).textTheme.bodyText1,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          errorMaxLines: 1,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(rSize(10)),
              borderSide: BorderSide(color: Colors.red, width: rSize(1))),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(rSize(10)),
              borderSide: BorderSide(color: Colors.red, width: rSize(2))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(rSize(10)),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: rSize(2))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(rSize(10)),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  width: rSize(1))),
        ),
      ),
    );
  }
}
