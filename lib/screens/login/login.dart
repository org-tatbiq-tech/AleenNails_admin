import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/auth_state.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:appointments/utils/secure_storage.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:appointments/widget/custom_container.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberMeValue = false;

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
    _userEmailController.addListener(() => setState(() {}));
    _rightContentAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1, curve: Curves.linear)));
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
    _userEmailController.dispose();
    _passwordController.dispose();
  }

  void errorCallback(FirebaseAuthException e) {
    Navigator.pop(context);

    /// TODO: Add flash
    // showErrorFlash(
    //   errorTitle: Languages.of(context)!.error,
    //   errorBody: e.message.toString(),
    //   context: context,
    // );
  }

  Future<void> validateAndLogin(BuildContext context) async {
    /// To remove in prod //
    Navigator.pushReplacementNamed(context, '/home');
    return;
    final form = _formKey.currentState;
    final authState = Provider.of<AuthenticationState>(context, listen: false);
    if (form!.validate()) {
      showLoaderDialog(context);
      final UserCredential? user = await authState.signInWithEmailAndPassword(
          _userEmailController.text, _passwordController.text, errorCallback);
      final userData = user?.user;
      if (userData != null) {
        if (_rememberMeValue) {
          UserSecureStorage.setAutoLogin('true');
        } else {
          UserSecureStorage.deleteAutoLogin();
        }
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  Widget buildRememberCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: rSize(40),
          child: FittedBox(
            child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: _rememberMeValue,
              onChanged: (newValue) {
                setState(() {
                  _rememberMeValue = newValue!;
                });
              },
              checkColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(rSize(4)),
              ),
              splashRadius: 0,
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Text(
          Languages.of(context)!.labelRememberMe,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
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
                      Languages.of(context)!.labelLogin,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
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
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Opacity(
                    opacity: _rightContentAnimation.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/aleen-logo-2.png'),
                          width: rSize(200),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: rSize(40),
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              Languages.of(context)!.labelEnterLoginDetails,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(fontSize: rSize(18)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: rSize(40),
                        ),
                        CustomInputField(
                          customInputFieldProps: CustomInputFieldProps(
                            controller: _userEmailController,
                            prefixIcon: IconTheme(
                              data: Theme.of(context).primaryIconTheme,
                              child: Icon(
                                FontAwesomeIcons.userAlt,
                                size: rSize(20),
                              ),
                            ),
                            labelText: Languages.of(context)!.labelUserName,
                            validator: validateNotEmpty,
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
                            labelText: Languages.of(context)!.labelPassword,
                            prefixIcon: IconTheme(
                              data: Theme.of(context).primaryIconTheme,
                              child: Icon(
                                FontAwesomeIcons.lock,
                                size: rSize(20),
                              ),
                            ),
                            validator: validateNotEmpty,
                          ),
                        ),
                        SizedBox(
                          height: rSize(15),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextButton(
                              customTextButtonProps: CustomTextButtonProps(
                                text:
                                    Languages.of(context)!.labelForgotPassword,
                                textColor:
                                    Theme.of(context).colorScheme.primary,
                                // fontSize: rSize(16),
                                onTap: () => {
                                  Navigator.pushNamed(
                                      context, '/forgetPassword'),
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: rSize(10),
                        ),
                        buildRememberCheckBox(),
                        SizedBox(
                          height: rSize(40),
                        ),
                        CustomButton(
                          customButtonProps: CustomButtonProps(
                            onTap: () => {
                              validateAndLogin(context),
                            },
                            text: Languages.of(context)!.labelLogin,
                            isPrimary: true,
                          ),
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Languages.of(context)!.labelNoAccount,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            CustomTextButton(
                              customTextButtonProps: CustomTextButtonProps(
                                text: Languages.of(context)!.labelRegisterNow,
                                textColor:
                                    Theme.of(context).colorScheme.primary,
                                onTap: () => {
                                  Navigator.pushNamed(context, '/register'),
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
