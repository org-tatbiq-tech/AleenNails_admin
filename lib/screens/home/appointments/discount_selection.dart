import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/widget/custom/custom_toggle.dart';
import 'package:common_widgets/counter_button.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_container.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscountSelection extends StatefulWidget {
  final int discountValue;
  final DiscountType discountType;
  final bool clientDiscount;
  const DiscountSelection({
    Key? key,
    this.discountType = DiscountType.fixed,
    this.discountValue = 0,
    this.clientDiscount = false,
  }) : super(key: key);

  @override
  State<DiscountSelection> createState() => _DiscountSelectionState();
}

class _DiscountSelectionState extends State<DiscountSelection> {
  final TextEditingController _discountController = TextEditingController();
  late double xAlign;
  @override
  void initState() {
    super.initState();
    xAlign = widget.discountType == DiscountType.percent ? 1 : -1;
    _discountController.text = widget.discountValue.toString();
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
                    ? int.parse(_discountController.text)
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Languages.of(context)!.labelAddDiscount.toTitleCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: rSize(18),
                          ),
                    ),
                    SizedBox(
                      width: rSize(10),
                    ),
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
                SizedBox(
                  height: rSize(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CounterButton(
                      discountController: _discountController,
                      maxLength: xAlign == 1
                          ? 2
                          : getNumberLength(appointmentsMgr
                              .selectedAppointment.servicesCost
                              .round()),
                      inputRangeMax: xAlign == 1
                          ? 99
                          : appointmentsMgr.selectedAppointment.servicesCost
                              .round(),
                      inputRangeMin: 0,
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                if (!widget.clientDiscount)
                  Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            getStringPrice(appointmentsMgr
                                .selectedAppointment.servicesCost),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: rSize(4),
                                  decorationColor:
                                      Theme.of(context).colorScheme.primary,
                                  decorationStyle: TextDecorationStyle.wavy,
                                ),
                          ),
                          Text(
                            getNewPrice(),
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            Languages.of(context)!.labelNewPrice,
                            style: Theme.of(context).textTheme.titleMedium,
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
                            _discountController.text = '0';
                          });
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
