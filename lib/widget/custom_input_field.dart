import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final CustomInputFieldProps customInputFieldProps;
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    symbol: '₪',
    decimalDigits: 1,
    turnOffGrouping: false,
  );

  CustomInputField({Key? key, required this.customInputFieldProps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    getColor({opacity = 1.0}) {
      if (customInputFieldProps.errorText.isEmpty) {
        return Theme.of(context).colorScheme.primary.withOpacity(opacity);
      } else {
        return Theme.of(context).colorScheme.error.withOpacity(opacity);
      }
    }

    getSuffixIcon() {
      if (customInputFieldProps.controller.text.isNotEmpty) {
        if (customInputFieldProps.isPassword) {
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
                  onPressed: () => customInputFieldProps.controller.clear(),
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
                  icon: Icon(customInputFieldProps.isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  color: getColor(),
                  onPressed: () => customInputFieldProps.togglePassword(),
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
              onPressed: () => customInputFieldProps.controller.clear(),
              constraints: const BoxConstraints(),
              padding: EdgeInsets.fromLTRB(0, 0, rSize(10), 0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          );
        }
      } else {
        if (customInputFieldProps.isPassword) {
          return IconTheme(
            data: Theme.of(context).iconTheme,
            child: IconButton(
              icon: Icon(customInputFieldProps.isPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility),
              color: getColor(),
              onPressed: () => customInputFieldProps.togglePassword(),
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

    return Card(
      clipBehavior: Clip.none,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          rSize(10),
        ),
      ),
      child: TextFormField(
        inputFormatters: customInputFieldProps.isCurrency
            ? [_formatter]
            : customInputFieldProps.inputFormatters ?? [],
        maxLength: customInputFieldProps.maxLength,
        controller: customInputFieldProps.controller,
        obscureText: customInputFieldProps.isPassword &&
            !customInputFieldProps.isPasswordVisible,
        cursorColor: Theme.of(context).colorScheme.primary,
        style: Theme.of(context).textTheme.caption,
        maxLines: customInputFieldProps.isDescription ? 5 : 1,
        keyboardType: customInputFieldProps.keyboardType,
        validator: customInputFieldProps.isConfirmPassword
            ? (value) => customInputFieldProps.validator(
                value, customInputFieldProps.passwordToConfirm)
            : (value) => customInputFieldProps.validator(context, value),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          constraints: BoxConstraints(
            maxHeight: rSize(50),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: rSize(20),
            vertical: rSize(10),
          ),
          filled: true,
          floatingLabelBehavior: customInputFieldProps.isSearch
              ? FloatingLabelBehavior.never
              : FloatingLabelBehavior.auto,
          fillColor: Theme.of(context).colorScheme.onBackground,
          errorStyle: TextStyle(
            fontSize: rSize(18),
          ),
          suffixIcon: getSuffixIcon(),
          prefixIconConstraints: BoxConstraints(
            maxWidth: rSize(200),
            minWidth: rSize(40),
          ),
          prefixIcon: !customInputFieldProps.isSearch
              ? customInputFieldProps.prefixIcon
              : IconTheme(
                  data: Theme.of(context).primaryIconTheme,
                  child: const Icon(
                    Icons.search,
                  ),
                ),
          hintText: customInputFieldProps.hintText,
          isDense: false,
          labelText: customInputFieldProps.isDescription ||
                  customInputFieldProps.hintText.isNotEmpty
              ? null
              : customInputFieldProps.labelText,
          hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: rSize(16),
                color: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .color
                    ?.withOpacity(0.6),
              ),
          floatingLabelStyle: Theme.of(context).textTheme.bodyText1,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          errorMaxLines: 1,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(rSize(10)),
            borderSide: BorderSide(
              color: Colors.red,
              width: rSize(1),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(rSize(10)),
            borderSide: BorderSide(
              color: Colors.red,
              width: rSize(1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              rSize(10),
            ),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: rSize(1),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              rSize(10),
            ),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: rSize(1),
            ),
          ),
        ),
      ),
    );
  }
}
