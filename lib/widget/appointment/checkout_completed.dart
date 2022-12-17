import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CheckoutCompleted extends StatefulWidget {
  const CheckoutCompleted({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CheckoutCompletedState();
  }
}

class CheckoutCompletedState extends State<CheckoutCompleted> {
  @override
  Widget build(BuildContext context) {
    navigateBack() {
      Navigator.pop(context);
    }

    return CustomContainer(
      imagePath: 'assets/images/background4.png',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(
            left: rSize(20),
            right: rSize(20),
            top: rSize(200),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/checkout.json',
                repeat: true,
                height: rSize(200),
                animate: true,
                alignment: Alignment.bottomCenter,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'checkout complete'.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: rSize(22),
                      color: successPrimaryColor,
                    ),
                textAlign: TextAlign.center,
              ),
              const Expanded(child: SizedBox()),
              CustomButton(
                customButtonProps: CustomButtonProps(
                  onTap: () => navigateBack(),
                  text: Languages.of(context)!.backLabel,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
