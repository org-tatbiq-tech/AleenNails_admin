import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/utils/validators.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:appointments/widget/custom_container.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();

  late Animation _leftContentAnimation;
  late Animation _rightContentAnimation;
  late Animation _backArrowAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    _leftContentAnimation = Tween(begin: 0.0, end: 100).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.3, curve: Curves.linear)));

    _rightContentAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1, curve: Curves.linear)));

    _backArrowAnimation = Tween(begin: -40.0, end: 60.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.8, 1, curve: Curves.linear)));

    _emailController.addListener(() => setState(() {}));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _emailController.dispose();
  }

  void submit() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomContainer(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: rSize(_leftContentAnimation.value.toDouble()),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.decal,
                      colors: [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.onBackground,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          Languages.of(context)!.labelPassword,
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                  fontSize: rSize(50),
                                  letterSpacing: rSize(50),
                                  shadows: [
                                    BoxShadow(
                                        offset: const Offset(4, 4),
                                        spreadRadius: 1,
                                        color: Theme.of(context).shadowColor)
                                  ],
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: rSize(20)),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).shadowColor,
                            offset: const Offset(0, 0),
                            blurRadius: 5,
                          ),
                        ]),
                    child: Opacity(
                      opacity: _rightContentAnimation.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                              image: const AssetImage(
                                  'assets/images/password.png'),
                              width: rSize(250),
                              fit: BoxFit.cover),
                          SizedBox(
                            height: rSize(40),
                          ),
                          Wrap(
                            spacing: rSize(5),
                            runSpacing: rSize(15),
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            children: [
                              Text(
                                Languages.of(context)!.labelForgotPassword,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(fontSize: rSize(28)),
                              ),
                              Text(
                                Languages.of(context)!.labelFMessage,
                                style: Theme.of(context).textTheme.subtitle1,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: rSize(40),
                          ),
                          CustomInputField(
                            customInputFieldProps: CustomInputFieldProps(
                              controller: _emailController,
                              prefixIcon: IconTheme(
                                data: Theme.of(context).primaryIconTheme,
                                child: Icon(
                                  FontAwesomeIcons.userAlt,
                                  size: rSize(20),
                                ),
                              ),
                              labelText: Languages.of(context)!.labelEmail,
                              validator: validateEmail,
                            ),
                          ),
                          SizedBox(
                            height: rSize(40),
                          ),
                          CustomButton(
                            customButtonProps: CustomButtonProps(
                              onTap: () => {
                                Navigator.pushReplacementNamed(
                                    context, '/loginScreen'),
                              },
                              text: Languages.of(context)!.submit,
                              isPrimary: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: rSize(_backArrowAnimation.value.toDouble()),
            left: rSize(120),
            child: EaseInAnimation(
              onTap: () => {Navigator.pop(context)},
              child: CustomIcon(
                customIconProps: CustomIconProps(
                  icon: Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
