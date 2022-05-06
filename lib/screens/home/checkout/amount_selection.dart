import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/input_validation.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/utils/validators.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountSelection extends StatefulWidget {
  const AmountSelection({Key? key}) : super(key: key);

  @override
  State<AmountSelection> createState() => _AmountSelectionState();
}

class _AmountSelectionState extends State<AmountSelection> {
  final TextEditingController _discountController =
      TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    _discountController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: 1,
    );
    _discountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _discountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: 'Amount',
            withBack: true,
            barHeight: 100,
            withSave: true,
            saveTap: () => {
              Navigator.pop(context),
            },
            withClipPath: true,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          top: false,
          left: false,
          right: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              rSize(30),
              rSize(30),
              rSize(30),
              0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Add Amount',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: rSize(18),
                      ),
                ),
                SizedBox(
                  height: rSize(5),
                ),
                CustomInputField(
                  customInputFieldProps: CustomInputFieldProps(
                    controller: _discountController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                      // LimitRangeTextInputFormatter(1, 100),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    prefixIcon: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: rSize(10),
                        ),
                        CustomIcon(
                          customIconProps: CustomIconProps(
                            icon: null,
                            path: 'assets/icons/shekel.png',
                            backgroundColor: Colors.transparent,
                            withPadding: true,
                            containerSize: 25,
                          ),
                        ),
                        SizedBox(
                          width: rSize(5),
                        ),
                        Container(
                          width: rSize(1),
                          color: Theme.of(context).colorScheme.primary,
                          margin: EdgeInsets.symmetric(
                            vertical: rSize(10),
                          ),
                        ),
                        SizedBox(
                          width: rSize(15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
