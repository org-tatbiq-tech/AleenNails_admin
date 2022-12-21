import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/auth_mgr.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:appointments/utils/validations.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_loading_dialog.dart';
import 'package:common_widgets/utils/flash_manager.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  void errorCallback(FirebaseAuthException e) {
    showErrorFlash(
      errorTitle: Languages.of(context)!.resetPassEmailSentErrorTitle,
      errorBody: Languages.of(context)!.resetPassEmailSentErrorBody,
      context: context,
      errorColor: errorPrimaryColor,
    );

    Navigator.pushNamedAndRemoveUntil(
        context, '/loginScreen', (Route<dynamic> route) => false);
  }

  void validateAndSubmit() async {
    final form = _formKey.currentState;
    final authState = Provider.of<AuthenticationMgr>(context, listen: false);
    if (form!.validate()) {
      showLoaderDialog(context);
      final result = await authState.sendPasswordResetEmail(
          _emailController.text, errorCallback);
      if (result == true) {
        showSuccessFlash(
          successTitle: Languages.of(context)!.resetPassEmailSentTitle,
          successBody: Languages.of(context)!.resetPassEmailSentSuccessBody,
          context: context,
          successColor: successPrimaryColor,
        );
      }
      Navigator.pushNamedAndRemoveUntil(
          context, '/loginScreen', (Route<dynamic> route) => false);
    }
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
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: isAndroid() ? rSize(10) : 0,
                            ),
                            child: CustomIcon(
                              customIconProps: CustomIconProps(
                                isDisabled: false,
                                onTap: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: rSize(25),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: rSize(60),
                      ),
                      Image(
                        image: const AssetImage('assets/images/lock.png'),
                        width: rSize(150),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: rSize(40),
                      ),
                      Column(
                        children: [
                          Text(
                            Languages.of(context)!.labelForgotPassword,
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(fontSize: rSize(28)),
                          ),
                          SizedBox(
                            height: rSize(10),
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
                              FontAwesomeIcons.userLarge,
                              size: rSize(20),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          labelText: Languages.of(context)!.labelEmail,
                          validator: emailValidation,
                        ),
                      ),
                      SizedBox(
                        height: rSize(40),
                      ),
                      CustomButton(
                        customButtonProps: CustomButtonProps(
                          onTap: () => validateAndSubmit(),
                          text: Languages.of(context)!.submitLabel,
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
    );
  }
}
