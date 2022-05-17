import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  int _value = 0;

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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: rSize(30),
          vertical: rSize(20),
        ),
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
    );
  }
}
