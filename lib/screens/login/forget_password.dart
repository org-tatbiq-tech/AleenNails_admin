import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/utils/validations.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  void submit() {}

  // Positioned(
  //   top: rSize(100),
  //   left: rSize(120),
  //   child: CustomIcon(
  //     customIconProps: CustomIconProps(
  //       isDisabled: false,
  //       onTap: () => {Navigator.pop(context)},
  //       icon: Icon(Icons.arrow_back),
  //     ),
  //   ),
  // ),

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
                              top: !isDeviceHasNotch() || isAndroid()
                                  ? rSize(10)
                                  : 0,
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
                          labelText: Languages.of(context)!.labelEmail,
                          validator: emailValidation,
                        ),
                      ),
                      SizedBox(
                        height: rSize(40),
                      ),
                      CustomButton(
                        customButtonProps: CustomButtonProps(
                          onTap: () => {},
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
