import 'package:appointments/data_types/components.dart';
import 'package:appointments/providers/services_mgr.dart';
import 'package:appointments/widget/picker_time_range_modal.dart';
import 'package:common_widgets/custom_app_bar.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_input_field.dart';
import 'package:common_widgets/custom_input_field_button.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/ease_in_animation.dart';
import 'package:common_widgets/image_picker_modal.dart';
import 'package:common_widgets/utils/date.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class NewService extends StatefulWidget {
  const NewService({Key? key}) : super(key: key);

  @override
  State<NewService> createState() => _NewServiceState();
}

class _NewServiceState extends State<NewService> {
  final ItemScrollController colorScrollController = ItemScrollController();
  final ItemPositionsListener colorPositionsListener =
      ItemPositionsListener.create();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _messageToClientController =
      TextEditingController();

  Duration durationValue = Duration(minutes: 90);
  int selectedColorIndex = 0;
  bool onlineBooking = true;

  @override
  void initState() {
    super.initState();
    colorPositionsListener.itemPositions.addListener(() {});
    _nameController.addListener(() => setState(() {}));
    _priceController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
    _messageToClientController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _messageToClientController.dispose();
  }

  _scrollToIndex(index, colors) {
    colorScrollController.scrollTo(
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
    List<Color> mediaList = [];
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

    List<Widget> mediaCards() {
      List<Widget> widgetList = mediaList.map((item) {
        return EaseInAnimation(
          beginAnimation: 0.98,
          onTap: () => {},
          child: Container(
            width: rSize(100),
            height: rSize(100),
            margin: EdgeInsets.only(
              right: rSize(15),
            ),
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  rSize(10),
                ),
              ),
            ),
            child: Image.asset(
              'assets/images/avatar_female.png',
              alignment: Alignment.center,
              fit: BoxFit.contain,
            ),
          ),
        );
      }).toList();
      widgetList.insert(
        0,
        EaseInAnimation(
          onTap: () => {
            showImagePickerModal(
              imagePickerModalProps: ImagePickerModalProps(
                context: context,
                saveImage: () => {},
              ),
            )
          },
          beginAnimation: 0.98,
          child: Padding(
            padding: EdgeInsets.only(right: rSize(20)),
            child: DottedBorder(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderType: BorderType.RRect,
              dashPattern: [rSize(6), rSize(4)],
              strokeWidth: rSize(1),
              radius: Radius.circular(
                rSize(10),
              ),
              child: SizedBox(
                width: rSize(100),
                height: rSize(100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomIcon(
                      customIconProps: CustomIconProps(
                        icon: null,
                        backgroundColor: Colors.transparent,
                        path: 'assets/icons/camera.png',
                        containerSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: rSize(2),
                    ),
                    Text(
                      'Add Media',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontSize: rSize(12),
                          ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      return widgetList;
    }

    Widget colorCard(index) {
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

    Widget renderServiceColors() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: rSize(5),
              left: rSize(10),
              right: rSize(10),
            ),
            child: Text(
              'Service Color',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: rSize(60),
            child: ScrollablePositionedList.builder(
              itemScrollController: colorScrollController,
              itemPositionsListener: colorPositionsListener,
              padding: EdgeInsets.symmetric(
                horizontal: rSize(20),
                vertical: rSize(10),
              ),
              scrollDirection: Axis.horizontal,
              itemCount: colors.length,
              itemBuilder: (context, index) => colorCard(index),
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
          Padding(
            padding: EdgeInsets.only(
              bottom: rSize(5),
            ),
            child: Text(
              'Permissions',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
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
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  EaseInAnimation(
                    onTap: () => {
                      showBottomModal(
                        bottomModalProps: BottomModalProps(
                          context: context,
                          enableDrag: true,
                          // showDragPen: true,
                          centerTitle: true,
                          title: 'Allow Clients to Book Online',
                          child: Text(
                            'If switched off clients will not be able to book this Service using the app. You will have to manually add appointments to your calendar.',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      )
                    },
                    child: CustomIcon(
                      customIconProps: CustomIconProps(
                        icon: null,
                        path: 'assets/icons/question.png',
                        containerSize: 25,
                        backgroundColor: Colors.transparent,
                        iconColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: rSize(10),
                  ),
                  Transform.scale(
                    scale: rSize(1.4),
                    alignment: Alignment.center,
                    child: Switch(
                      onChanged: (bool value) {
                        setState(() {
                          onlineBooking = value;
                        });
                      },
                      splashRadius: 0,
                      activeColor: Theme.of(context).colorScheme.primary,
                      inactiveThumbColor:
                          Theme.of(context).colorScheme.onBackground,
                      inactiveTrackColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      value: onlineBooking,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      );
    }

    Widget renderMessageToClient() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: rSize(5),
                  left: rSize(10),
                  right: rSize(10),
                ),
                child: Text(
                  'Message to Client',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              EaseInAnimation(
                onTap: () => {
                  showBottomModal(
                    bottomModalProps: BottomModalProps(
                      context: context,
                      enableDrag: true,
                      // showDragPen: true,
                      centerTitle: true,
                      title: 'Message to Client',
                      child: Text(
                        'This message will be sent to your client before the appointment. E.g Please do not eat 1 hour before the appointment.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  )
                },
                child: CustomIcon(
                  customIconProps: CustomIconProps(
                    icon: null,
                    path: 'assets/icons/question.png',
                    containerSize: 25,
                    backgroundColor: Colors.transparent,
                    iconColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: rSize(5),
          ),
          SizedBox(
            height: rSize(120),
            child: CustomInputField(
              customInputFieldProps: CustomInputFieldProps(
                controller: _messageToClientController,
                isDescription: true,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ],
      );
    }

    Widget _renderMedia() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: rSize(10),
              right: rSize(10),
            ),
            child: Text(
              'Media',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              // horizontal: rSize(20),
              top: rSize(15),
            ),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: mediaCards(),
            ),
          ),
        ],
      );
    }

    Widget renderDescription() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: rSize(5),
              left: rSize(10),
              right: rSize(10),
            ),
            child: Text(
              'Service Description',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: rSize(120),
            child: CustomInputField(
              customInputFieldProps: CustomInputFieldProps(
                hintText:
                    'Example: This relaxing service included an herbal soak.',
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                isDescription: true,
              ),
            ),
          ),
        ],
      );
    }

    Widget renderPriceDuration() {
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
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: rSize(5),
                      left: rSize(10),
                      right: rSize(10),
                    ),
                    child: Text(
                      'Price',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  CustomInputField(
                    customInputFieldProps: CustomInputFieldProps(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      isCurrency: false,
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
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: rSize(5),
                      left: rSize(10),
                      right: rSize(10),
                    ),
                    child: Text(
                      'Duration',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  CustomInputFieldButton(
                    text: getDateTimeFormat(
                      // dateTime: durationValue,
                      format: 'HH:mm',
                    ),
                    onTap: () => showPickerTimeRangeModal(
                      pickerTimeRangeModalProps: PickerTimeRangeModalProps(
                        context: context,
                        title: 'Duration',
                        // startTimeValue: durationValue,
                        pickerTimeRangType: PickerTimeRangType.single,
                        // primaryAction: (DateTime x) => setState(() {
                        //   durationValue = x;
                        // },
                      ),
                    ),
                  ),
                  // ),
                ],
              ),
            ),
          ]);
    }

    Widget renderServiceName() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: rSize(5),
              left: rSize(10),
              right: rSize(10),
            ),
            child: Text(
              'Service Name',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: rSize(5),
          ),
          CustomInputField(
            customInputFieldProps: CustomInputFieldProps(
              controller: _nameController,
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      );
    }

    saveService() {
      final servicesMgr = Provider.of<ServicesMgr>(context, listen: false);
      Service newService = Service(
        id: '',
        name: _nameController.text,
        cost: double.parse(_priceController.text),
        duration: durationValue,
        colorID: colors[selectedColorIndex].value,
        onlineBooking: onlineBooking,
        description: _descriptionController.text,
        noteMessage: _messageToClientController.text,
      );

      servicesMgr.submitNewService(newService);
      Navigator.pop(context);
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
            // withClipPath: true,
            withSave: true,
            // barHeight: 70,
            saveTap: () => {saveService()},
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
              renderServiceName(),
              SizedBox(
                height: rSize(20),
              ),
              renderPriceDuration(),
              SizedBox(
                height: rSize(20),
              ),
              renderServiceColors(),
              SizedBox(
                height: rSize(20),
              ),
              renderDescription(),
              SizedBox(
                height: rSize(20),
              ),
              _renderMedia(),
              SizedBox(
                height: rSize(30),
              ),
              renderMessageToClient(),
              SizedBox(
                height: rSize(20),
              ),
              _renderPermissions(),
            ],
          ),
        ),
      ),
    );
  }
}
