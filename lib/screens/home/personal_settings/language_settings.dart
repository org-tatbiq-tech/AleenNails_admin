import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/localization/utils.dart';
import 'package:appointments/providers/langs.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  int _value = 0;
  int _oldValue = 0;

  @override
  void initState() {
    final localeMgr = Provider.of<LocaleData>(context, listen: false);
    int idx =
        supportedLocale.indexWhere((element) => element == localeMgr.locale);
    _value = idx;
    _oldValue = idx;
    super.initState();
  }

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

  saveLanguage() {
    final localeMgr = Provider.of<LocaleData>(context, listen: false);
    localeMgr.setLocale(supportedLocale[_value]);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        customAppBarProps: CustomAppBarProps(
          titleText: Languages.of(context)!.labelLanguage,
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
                      Languages.of(context)!.languageMsg,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: rSize(20),
                    ),
                    renderLanguage(name: english, value: 0),
                    renderLanguage(name: arabic, value: 1),
                    renderLanguage(name: hebrew, value: 2),
                  ],
                ),
              ),
              CustomButton(
                customButtonProps: CustomButtonProps(
                  onTap: () => {saveLanguage()},
                  text: Languages.of(context)!.saveLabel,
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
