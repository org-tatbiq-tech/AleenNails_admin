import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/auth_mgr.dart';
import 'package:appointments/screens/login/forget_password.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:appointments/utils/secure_storage.dart';
import 'package:appointments/utils/validations.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/custom_text_button.dart';

import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/layout.dart';
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

  void _togglePassword() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    _userEmailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _userEmailController.dispose();
    _passwordController.dispose();
  }

  void errorCallback(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        showErrorFlash(
          errorTitle: Languages.of(context)!.authUserNotFoundErrorTitle,
          errorBody: Languages.of(context)!.authUserNotFoundErrorBody,
          context: context,
          errorColor: errorPrimaryColor,
        );
        break;
      case 'wrong-password':
        showErrorFlash(
          errorTitle: Languages.of(context)!.authWrongPassErrorTitle,
          errorBody: Languages.of(context)!.authWrongPassErrorBody,
          context: context,
          errorColor: errorPrimaryColor,
        );
        break;
      default:
        // Failed login
        showErrorFlash(
          errorTitle: Languages.of(context)!.authLoginFailedErrorTitle,
          errorBody: Languages.of(context)!.authLoginFailedErrorBody,
          context: context,
          errorColor: errorPrimaryColor,
        );
        break;
    }
    Navigator.pop(context);
  }

  Future<void> validateAndLogin(BuildContext context) async {
    final form = _formKey.currentState;
    final authMgr = Provider.of<AuthenticationMgr>(context, listen: false);
    if (form!.validate()) {
      showLoaderDialog(context);
      authMgr
          .checkIfAdmin(_userEmailController.text.trim().toLowerCase())
          .then((res) async {
        if (!res) {
          showErrorFlash(
            context: context,
            errorTitle: Languages.of(context)!.authAdminErrorTitle,
            errorBody: Languages.of(context)!.authAdminErrorBody,
            errorColor: errorPrimaryColor,
          );
          Navigator.pop(context);
          return;
        }
        final UserCredential? user = await authMgr.signInWithEmailAndPassword(
            _userEmailController.text, _passwordController.text, errorCallback);
        final userData = user?.user;
        if (userData != null) {
          if (_rememberMeValue) {
            UserSecureStorage.setAutoLogin('true');
          } else {
            UserSecureStorage.deleteAutoLogin();
          }
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
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
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/background4.png',
                  ),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: rSize(30),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/main_logo.png'),
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
                            textAlign: TextAlign.center,
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
                          keyboardType: TextInputType.emailAddress,
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
                        height: rSize(15),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextButton(
                            customTextButtonProps: CustomTextButtonProps(
                              text: Languages.of(context)!.labelForgotPassword,
                              textColor: Theme.of(context).colorScheme.primary,
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordScreen(),
                                  ),
                                ),
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
                          text: Languages.of(context)!.labelSignIn,
                          isPrimary: true,
                        ),
                      ),
                    ],
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
