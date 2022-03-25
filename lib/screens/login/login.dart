import 'package:appointments/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  late Animation _leftContentAnimation;
  late Animation _rightContentAnimation;
  late AnimationController _controller;

  void _togglePassword() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

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
    _userNameController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
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
                          'LOGIN',
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
                  child: Opacity(
                    opacity: _rightContentAnimation.value,
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
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconTheme(
                              data: Theme.of(context).primaryIconTheme,
                              child: Icon(
                                FontAwesomeIcons.android,
                                size: rSize(100),
                              ),
                            ),
                            Wrap(
                              children: [
                                Text(
                                  'Please enter the details below to continue.',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: rSize(40),
                            ),
                            CustomInputField(
                              customInputFieldProps: CustomInputFieldProps(
                                controller: _userNameController,
                                prefixIcon: IconTheme(
                                  data: Theme.of(context).primaryIconTheme,
                                  child: Icon(
                                    FontAwesomeIcons.userAlt,
                                    size: rSize(20),
                                  ),
                                ),
                                labelText: 'User Name',
                              ),
                            ),
                            SizedBox(
                              height: rSize(20),
                            ),
                            CustomInputField(
                              customInputFieldProps: CustomInputFieldProps(
                                controller: _passwordController,
                                isPassword: true,
                                isPasswordVisible: _isPasswordVisible,
                                togglePassword: _togglePassword,
                                labelText: 'Password',
                                prefixIcon: IconTheme(
                                  data: Theme.of(context).primaryIconTheme,
                                  child: Icon(
                                    FontAwesomeIcons.lock,
                                    size: rSize(20),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: rSize(20),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomTextButton(
                                    customTextButtonProps:
                                        CustomTextButtonProps(
                                  text: 'Forget Password?',
                                  textColor:
                                      Theme.of(context).colorScheme.primary,
                                  fontSize: rSize(16),
                                  onTap: () => {
                                    _controller.reset(),
                                    _controller.forward()
                                  },
                                ))
                              ],
                            ),
                            SizedBox(
                              height: rSize(40),
                            ),
                            CustomButton(
                              customButtonProps: CustomButtonProps(
                                onTap: () => {},
                                text: 'Login',
                                isPrimary: true,
                              ),
                            ),
                            SizedBox(
                              height: rSize(20),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Dont have an account? ',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                CustomTextButton(
                                    customTextButtonProps:
                                        CustomTextButtonProps(
                                  text: 'Register',
                                  textColor:
                                      Theme.of(context).colorScheme.primary,
                                  onTap: () => {},
                                ))
                              ],
                            ),
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
