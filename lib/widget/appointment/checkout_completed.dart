import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/general.dart';
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
                'assets/images/appointment_awaiting.json',
                repeat: true,
                height: rSize(200),
                animate: true,
                alignment: Alignment.bottomCenter,
              ),
              Text(
                'Appointment is awaiting business confirmation'.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: rSize(20),
                      color: warningPrimaryColor,
                    ),
                textAlign: TextAlign.center,
              ),
              const Expanded(child: SizedBox()),
              Text(
                'we will let you know after your appointment will be confirmed'
                    .toCapitalized(),
                style: Theme.of(context).textTheme.bodyText1?.copyWith(),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: rSize(15),
              ),
              CustomButton(
                customButtonProps: CustomButtonProps(
                  onTap: () => Navigator.pop(context),
                  text: Languages.of(context)!.okLabel,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
