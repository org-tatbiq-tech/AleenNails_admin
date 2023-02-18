import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/providers/theme_provider.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
      AppointmentsMgr appointmentsMgr =
          Provider.of<AppointmentsMgr>(context, listen: false);
      appointmentsMgr.setSelectedAppointment(
          appointmentID: appointmentsMgr.selectedAppointment.id);
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
                repeat: false,
                width: rSize(180),
                animate: true,
                alignment: Alignment.bottomCenter,
              ),
              SizedBox(
                height: rSize(10),
              ),
              Text(
                'checkout complete'.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
