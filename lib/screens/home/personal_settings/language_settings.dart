import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:flutter/material.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  int _value = 0;
  int _oldValue = 0;

  bool isButtonDisabled() {
    if (_value == _oldValue) {
      return true;
    }
    return false;
  }

  Widget renderLanguage({
    required String name,
    required int value,
  }) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _value,
          onChanged: (int? value) {
            setState(() {
              _value = value ?? 0;
            });
          },
          splashRadius: 0,
          activeColor: Theme.of(context).colorScheme.primary,
          materialTapTargetSize: MaterialTapTargetSize.padded,
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: 'Language',
          withBack: true,
          withBorder: false,
          barHeight: 110,
          withClipPath: true,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        top: false,
        right: false,
        left: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: rSize(30),
            right: rSize(30),
            top: rSize(20),
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Select your Application Language',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: rSize(20),
                    ),
                    renderLanguage(name: 'English', value: 0),
                    renderLanguage(name: 'Arabic', value: 1),
                    renderLanguage(name: 'Hebrew', value: 2),
                  ],
                ),
              ),
              CustomButton(
                customButtonProps: CustomButtonProps(
                  onTap: () => {
                    Navigator.pop(context),
                  },
                  text: 'Save',
                  isPrimary: true,
                  isDisabled: isButtonDisabled(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
