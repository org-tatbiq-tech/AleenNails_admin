import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_container.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:appointments/widget/custom_input_field_button.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:appointments/widget/picker_time_range_modal.dart';
import 'package:flutter/material.dart';

class NewService extends StatefulWidget {
  const NewService({Key? key}) : super(key: key);

  @override
  State<NewService> createState() => _NewServiceState();
}

class _NewServiceState extends State<NewService> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  int selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    _priceController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color1 = Color.fromARGB(255, 204, 136, 218);
    Color color2 = Color.fromARGB(255, 195, 107, 156);
    Color color3 = Color.fromARGB(255, 209, 156, 187);
    Color color4 = Color.fromARGB(255, 110, 155, 161);
    Color color5 = Color.fromARGB(255, 240, 193, 176);
    List<Color> colors = [
      color1,
      color2,
      color3,
      color4,
      color5,
    ];

    Widget _createColorCard(index) {
      return EaseInAnimation(
        onTap: () => {
          setState(
            () => {
              selectedColorIndex = index,
            },
          ),
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: selectedColorIndex == index ? rSize(45) : rSize(40),
          height: rSize(40),
          margin: EdgeInsets.only(
            right: rSize(15),
          ),
          decoration: BoxDecoration(
            color: colors[index],
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
            border: Border.all(
              width: rSize(2),
              color: selectedColorIndex == index
                  ? darken(
                      Theme.of(context).colorScheme.primary,
                    )
                  : colors[index],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                rSize(20),
              ),
            ),
          ),
        ),
      );
    }

    Widget _renderServiceColors() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Service Color',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
                ),
          ),
          SizedBox(
            height: rSize(15),
          ),
          SizedBox(
            height: rSize(40),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: rSize(20),
              ),
              scrollDirection: Axis.horizontal,
              itemCount: colors.length,
              itemBuilder: (context, index) => _createColorCard(index),
            ),
          ),
        ],
      );
    }

    return CustomContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: 'New Service',
            withBack: true,
            withClipPath: false,
            customIcon: Icon(
              Icons.save,
              size: rSize(24),
            ),
            customIconTap: () => {},
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: rSize(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Service Name',
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
                      controller: _nameController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: rSize(20),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Price',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontSize: rSize(18),
                                    ),
                          ),
                          SizedBox(
                            height: rSize(10),
                          ),
                          CustomInputField(
                            customInputFieldProps: CustomInputFieldProps(
                              controller: _priceController,
                              isCurrency: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: rSize(15),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Duration',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontSize: rSize(18),
                                    ),
                          ),
                          SizedBox(
                            height: rSize(10),
                          ),
                          CustomInputFieldButton(
                            text: '1h:10m',
                            onTap: () => showPickerTimeRangeModal(
                              pickerTimeRangeModalProps:
                                  PickerTimeRangeModalProps(
                                context: context,
                                title: 'Duration',
                                pickerTimeRangType: PickerTimeRangType.single,
                                // primaryAction: () => print('object'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
              SizedBox(
                height: rSize(30),
              ),
              _renderServiceColors(),
            ],
          ),
        ),
      ),
    );
  }
}
