import 'dart:async';
import 'package:appointments/data_types.dart';
import 'package:appointments/utils/layout_util.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RegisterOTPScreen extends StatefulWidget {
  const RegisterOTPScreen({Key? key}) : super(key: key);

  @override
  State<RegisterOTPScreen> createState() => _RegisterOTPScreenState();
}

class _RegisterOTPScreenState extends State<RegisterOTPScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _mobileController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  late Animation _leftContentAnimation;
  late Animation _rightContentAnimation;
  late AnimationController _controller;
  String _currentText = '';
  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    _leftContentAnimation = Tween(begin: 0.0, end: 100).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.3, curve: Curves.linear)));

    _rightContentAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1, curve: Curves.linear)));
    _mobileController.addListener(() => setState(() {}));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    errorController!.close();
    _controller.dispose();
    _mobileController.dispose();
  }

  Widget _buildTextFieldOTP() {
    return PinCodeTextField(
      appContext: context,
      textStyle: Theme.of(context).textTheme.headline2?.copyWith(
            fontSize: rSize(24),
            color: Theme.of(context).colorScheme.background,
          ),
      pastedTextStyle:
          Theme.of(context).textTheme.headline2?.copyWith(fontSize: rSize(24)),
      length: 6,
      obscureText: true,
      // obscuringCharacter: '*',
      obscuringWidget: Icon(
        FontAwesomeIcons.asterisk,
        color: Theme.of(context).colorScheme.background,
        size: rSize(20),
      ),
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      // validator: (v) {
      //   if (v!.length < 3) {
      //     return "I'm from validator";
      //   } else {
      //     return null;
      //   }
      // },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(rSize(10)),
        fieldHeight: rSize(50),
        fieldWidth: rSize(40),
        activeFillColor: Theme.of(context).colorScheme.primary,
        selectedFillColor: Theme.of(context).colorScheme.primaryContainer,
        inactiveFillColor: Theme.of(context).colorScheme.primary,
        activeColor: Theme.of(context).colorScheme.primary,
        selectedColor: Theme.of(context).colorScheme.onPrimary,
        inactiveColor: Theme.of(context).colorScheme.primary,
      ),
      showCursor: false,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      errorAnimationController: errorController,
      // controller: otpController,
      keyboardType: TextInputType.number,
      boxShadows: const [
        BoxShadow(
            // offset: Offset(0, 1),
            // color: Colors.black12,
            // blurRadius: 10,
            )
      ],
      onCompleted: (v) {
        print("Completed");
      },
      // onTap: () {
      //   print("Pressed");
      // },
      onChanged: (value) {
        setState(() {
          _currentText = value;
        });
      },
      // beforeTextPaste: (text) {
      //   print("Allowing to paste $text");
      //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
      //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
      //   return true;
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),

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
                          'OTP',
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
                      padding: EdgeInsets.symmetric(
                          horizontal: rSize(20), vertical: rSize(80)),
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
                            Image(
                                image: AssetImage('assets/images/otp.png'),
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
                                  'Verification Code',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(fontSize: rSize(28)),
                                ),
                                Wrap(
                                  spacing: rSize(5),
                                  runSpacing: rSize(18),
                                  alignment: WrapAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'We have sent the code verification to Your Mobile Number ',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                      textAlign: TextAlign.center,
                                    ),
                                    Wrap(
                                      spacing: rSize(5),
                                      runSpacing: rSize(8),
                                      alignment: WrapAlignment.center,
                                      runAlignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                          '0505800955',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              ?.copyWith(fontSize: rSize(16)),
                                        ),
                                        // CustomIcon(
                                        //   containerSize: 30,
                                        //   icon: IconTheme(
                                        //       child: Icon(
                                        //         Icons.edit,
                                        //         size: rSize(20),
                                        //       ),
                                        //       data: Theme.of(context)
                                        //           .primaryIconTheme),
                                        // ),
                                        CustomTextButton(
                                            customTextButtonProps:
                                                CustomTextButtonProps(
                                          fontSize: rSize(16),
                                          textColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          onTap: () => {},
                                          text: 'Change',
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: rSize(40),
                            ),
                            _buildTextFieldOTP(),
                            SizedBox(
                              height: rSize(20),
                            ),
                            CustomTextButton(
                                customTextButtonProps: CustomTextButtonProps(
                              fontSize: rSize(18),
                              textColor: Theme.of(context).colorScheme.primary,
                              onTap: () => {},
                              text: 'Resend Code',
                            )),
                            SizedBox(
                              height: rSize(40),
                            ),
                            CustomButton(
                              customButtonProps: CustomButtonProps(
                                onTap: () => {},
                                text: 'Submit',
                                isPrimary: true,
                              ),
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
