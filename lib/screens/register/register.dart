import 'package:appointments/localization/language/languages.dart';
import 'package:common_widgets/utils/input_validation.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:appointments/widget/custom_container.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_state.dart';

class RegisterMainScreen extends StatefulWidget {
  const RegisterMainScreen({Key? key}) : super(key: key);

  @override
  State<RegisterMainScreen> createState() => _RegisterMainScreenState();
}

class _RegisterMainScreenState extends State<RegisterMainScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isRepeatPasswordVisible = false;
  late Animation _leftContentAnimation;
  late Animation _rightContentAnimation;
  late AnimationController _controller;

  void _togglePassword() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleRepeatPassword() {
    setState(() {
      _isRepeatPasswordVisible = !_isRepeatPasswordVisible;
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
    _repeatPasswordController.addListener(() => setState(() {}));
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
    _userNameController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _emailController.dispose();
  }

  void errorCallback(FirebaseAuthException e) {
    Navigator.pop(context);
    // showErrorFlash(
    //   errorTitle: Languages.of(context)!.error,
    //   errorBody: e.message.toString(),
    //   context: context,
    // );
  }

  void validateAndRegister() async {
    final form = _formKey.currentState;
    final authState = Provider.of<AuthenticationState>(context, listen: false);
    if (form!.validate()) {
      showLoaderDialog(context);
      final UserCredential? user = await authState.registerAccount(
        _emailController.text,
        _userNameController.text,
        _passwordController.text,
        errorCallback,
      );
      if (user?.user != null) {
        Navigator.pushNamed(context, '/register/registerMobile');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      Languages.of(context)!.labelRegister,
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
                    ]),
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
                            image: const AssetImage('assets/images/logo.png'),
                            width: rSize(250),
                            fit: BoxFit.cover),
                        SizedBox(
                          height: rSize(40),
                        ),
                        Wrap(
                          children: [
                            Text(
                              Languages.of(context)!.labelEnterLoginDetails,
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
                                FontAwesomeIcons.user,
                                size: rSize(20),
                              ),
                            ),
                            labelText: Languages.of(context)!.labelUserName,
                            validator: fullNameValidation,
                          ),
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        CustomInputField(
                          customInputFieldProps: CustomInputFieldProps(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: IconTheme(
                              data: Theme.of(context).primaryIconTheme,
                              child: Icon(
                                Icons.email,
                                size: rSize(22),
                              ),
                            ),
                            labelText: Languages.of(context)!.labelEmail,
                            validator: emailValidation,
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
                            validator: passwordValidation,
                          ),
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        CustomInputField(
                          customInputFieldProps: CustomInputFieldProps(
                            controller: _repeatPasswordController,
                            isPassword: true,
                            isPasswordVisible: _isRepeatPasswordVisible,
                            togglePassword: _toggleRepeatPassword,
                            passwordToConfirm: _passwordController.text,
                            isConfirmPassword: true,
                            labelText: Languages.of(context)!.labelRepeatPass,
                            prefixIcon: IconTheme(
                              data: Theme.of(context).primaryIconTheme,
                              child: Icon(
                                FontAwesomeIcons.lock,
                                size: rSize(20),
                              ),
                            ),
                            validator: confirmPasswordValidation,
                          ),
                        ),
                        SizedBox(
                          height: rSize(20),
                        ),
                        Wrap(
                          spacing: rSize(5),
                          runSpacing: rSize(5),
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          children: [
                            Text(
                              Languages.of(context)!
                                  .labelRegistrationConfirmMsg,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            CustomTextButton(
                              customTextButtonProps: CustomTextButtonProps(
                                text:
                                    Languages.of(context)!.labelTermsConditions,
                                textColor:
                                    Theme.of(context).colorScheme.primary,
                                onTap: () => {},
                              ),
                            ),
                            Text(
                              '&',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            CustomTextButton(
                              customTextButtonProps: CustomTextButtonProps(
                                text: Languages.of(context)!.labelPrivacyPolicy,
                                textColor:
                                    Theme.of(context).colorScheme.primary,
                                onTap: () => {},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: rSize(40),
                        ),
                        CustomButton(
                          customButtonProps: CustomButtonProps(
                            onTap: () => {
                              validateAndRegister(),
                            },
                            text: Languages.of(context)!.labelRegister,
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
                              Languages.of(context)!.labelAlreadyHaveAcc,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            CustomTextButton(
                                customTextButtonProps: CustomTextButtonProps(
                              text: Languages.of(context)!.labelLogin,
                              textColor: Theme.of(context).colorScheme.primary,
                              onTap: () => {
                                Navigator.pushReplacementNamed(
                                    context, '/loginScreen'),
                              },
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
