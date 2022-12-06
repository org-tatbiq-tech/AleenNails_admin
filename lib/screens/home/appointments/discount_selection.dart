import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/widget/custom/custom_toggle.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:common_widgets/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DiscountSelection extends StatefulWidget {
  const DiscountSelection({Key? key}) : super(key: key);

  @override
  State<DiscountSelection> createState() => _DiscountSelectionState();
}

class _DiscountSelectionState extends State<DiscountSelection> {
  final TextEditingController _discountController = TextEditingController();
  late double xAlign;
  @override
  void initState() {
    super.initState();
    xAlign = -1;
    _discountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _discountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appointmentsMgr =
        Provider.of<AppointmentsMgr>(context, listen: false);
    String getNewPrice() {
      if (_discountController.text.isNotEmpty) {
        double discountValue = double.parse(_discountController.text);

        if (xAlign == 1) {
          return getStringPrice(
              appointmentsMgr.selectedAppointment.servicesCost *
                  ((100 - discountValue) / 100));
        } else {
          return getStringPrice(
              appointmentsMgr.selectedAppointment.servicesCost - discountValue);
        }
      }
      return getStringPrice(appointmentsMgr.selectedAppointment.servicesCost);
    }

    getNumberLength(int value) {
      value.toString().length;
    }

    return CustomContainer(
      imagePath: 'assets/images/background4.png',
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: Languages.of(context)!.labelAddDiscount,
            withBack: true,
            isTransparent: true,
            withSave: true,
            saveText: Languages.of(context)!.saveLabel,
            saveTap: () => {
              Navigator.pop(context, {
                'discount': _discountController.text.isNotEmpty
                    ? double.parse(_discountController.text)
                    : 0,
                'type': xAlign == 1 ? DiscountType.percent : DiscountType.fixed,
              }),
            },
          ),
        ),
        body: SafeArea(
          top: false,
          left: false,
          right: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              rSize(30),
              rSize(30),
              rSize(30),
              rSize(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  Languages.of(context)!.labelAddDiscount.toTitleCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: rSize(18),
                      ),
                ),
                SizedBox(
                  height: rSize(10),
                ),
                CustomInputField(
                  customInputFieldProps: CustomInputFieldProps(
                    controller: _discountController,
                    autoFocus: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(xAlign == 1
                          ? 2
                          : getNumberLength(appointmentsMgr
                              .selectedAppointment.servicesCost
                              .round())),
                      LimitRangeTextInputFormatter(
                          0,
                          xAlign == 1
                              ? 99
                              : appointmentsMgr.selectedAppointment.servicesCost
                                  .round()),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    prefixIcon: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIcon(
                          customIconProps: CustomIconProps(
                            icon: null,
                            path: xAlign == 1
                                ? 'assets/icons/percent.png'
                                : 'assets/icons/shekel.png',
                            backgroundColor: Colors.transparent,
                            iconColor: Theme.of(context).colorScheme.primary,
                            withPadding: false,
                            containerSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Column(
                  children: [
                    Text(
                      getNewPrice(),
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      Languages.of(context)!.labelNewPrice,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                SizedBox(
                  height: rSize(20),
                ),
                CustomToggle(
                  width: rSize(300),
                  height: rSize(40),
                  xAlign: xAlign,
                  setXAlign: (double value) {
                    setState(() {
                      xAlign = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
