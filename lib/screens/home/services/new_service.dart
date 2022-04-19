import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_input_field.dart';
import 'package:appointments/widget/custom_input_field_button.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:appointments/widget/picker_time_range_modal.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class NewService extends StatefulWidget {
  const NewService({Key? key}) : super(key: key);

  @override
  State<NewService> createState() => _NewServiceState();
}

class _NewServiceState extends State<NewService> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? durationValue;
  int selectedColorIndex = 0;
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(() {});
    _nameController.addListener(() => setState(() {}));
    _priceController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
  }

  _scrollToIndex(index, colors) {
    itemScrollController.scrollTo(
      alignment: index / (colors.length + 1),
      index: index,
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 300),
    );
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
      color1,
      color2,
      color3,
      color4,
      color5,
    ];

    Widget _colorCard(index) {
      return EaseInAnimation(
        onTap: () => {
          _scrollToIndex(index, colors),
          setState(
            () => {
              selectedColorIndex = index,
            },
          ),
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: rSize(40),
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
          // SizedBox(
          //   height: rSize(15),
          // ),
          SizedBox(
            height: rSize(60),
            child: ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              padding: EdgeInsets.symmetric(
                horizontal: rSize(20),
                vertical: rSize(10),
              ),
              scrollDirection: Axis.horizontal,
              itemCount: colors.length,
              itemBuilder: (context, index) => _colorCard(index),
            ),
          ),
        ],
      );
    }

    Widget _renderPermissions() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Permissions',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Allow Clients to Book Online',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: rSize(18),
                    ),
              ),
              SizedBox(
                width: rSize(90),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    onChanged: (bool value) {
                      setState(() {
                        isEnabled = value;
                      });
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                    value: isEnabled,
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }

    Widget _renderMedia() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Media',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
                ),
          ),
          SizedBox(
            height: rSize(10),
          ),
          SizedBox(
            height: rSize(120),
            child: CustomInputField(
              customInputFieldProps: CustomInputFieldProps(
                controller: _descriptionController,
                isDescription: true,
              ),
            ),
          ),
        ],
      );
    }

    Widget _renderDescription() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Service Description',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: rSize(18),
                ),
          ),
          SizedBox(
            height: rSize(10),
          ),
          SizedBox(
            height: rSize(120),
            child: CustomInputField(
              customInputFieldProps: CustomInputFieldProps(
                controller: _descriptionController,
                isDescription: true,
              ),
            ),
          ),
        ],
      );
    }

    Widget _renderPriceDuration() {
      return Row(
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
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontSize: rSize(18),
                        ),
                  ),
                  SizedBox(
                    height: rSize(10),
                  ),
                  CustomInputFieldButton(
                    text: getDateTimeFormat(
                      dateTime: durationValue,
                      format: 'HH:mm',
                    ),
                    onTap: () => showPickerTimeRangeModal(
                      pickerTimeRangeModalProps: PickerTimeRangeModalProps(
                        context: context,
                        title: 'Duration',
                        startTimeValue: durationValue,
                        pickerTimeRangType: PickerTimeRangType.single,
                        primaryAction: (DateTime x) => setState(() {
                          durationValue = x;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]);
    }

    Widget _renderServiceName() {
      return Column(
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
      );
    }

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
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(30),
            vertical: rSize(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _renderServiceName(),
              SizedBox(
                height: rSize(20),
              ),
              _renderPriceDuration(),
              SizedBox(
                height: rSize(30),
              ),
              _renderServiceColors(),
              SizedBox(
                height: rSize(30),
              ),
              _renderDescription(),
              SizedBox(
                height: rSize(30),
              ),
              _renderMedia(),
              SizedBox(
                height: rSize(30),
              ),
              _renderPermissions(),
            ],
          ),
        ),
      ),
    );
  }
}
