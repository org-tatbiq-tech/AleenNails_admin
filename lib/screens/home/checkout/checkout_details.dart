import 'package:appointments/animations/fade_animation.dart';
import 'package:appointments/screens/home/services/services.dart';
import 'package:appointments/utils/data_types.dart';
import 'package:appointments/utils/date.dart';
import 'package:appointments/utils/input_validation.dart';
import 'package:appointments/utils/layout.dart';
import 'package:appointments/widget/close_slidable_on_tab.dart';
import 'package:appointments/widget/contact_card.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_avatar.dart';
import 'package:appointments/widget/custom_button_widget.dart';
import 'package:appointments/widget/custom_modal.dart';
import 'package:appointments/widget/custom_slide_able.dart';
import 'package:appointments/widget/custom_status.dart';
import 'package:appointments/widget/custom_text_button.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:appointments/widget/custom_icon.dart';
import 'package:appointments/widget/over_popup.dart';
import 'package:appointments/widget/service_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CheckoutDetails extends StatefulWidget {
  const CheckoutDetails({Key? key}) : super(key: key);

  @override
  _CheckoutDetailsState createState() => _CheckoutDetailsState();
}

class _CheckoutDetailsState extends State<CheckoutDetails> {
  List<Widget> chargeWidgetList = [];
  GlobalKey addItemButtonKey = GlobalKey();
  Service service = Service(
    id: '12304042032',
    name: 'Service Name',
    duration: '2h',
    startTime: kToday,
    endTime: DateTime(kToday.year, kToday.month, kToday.day, kToday.hour + 1),
    createdByBusiness: true,
    price: 25,
  );
  List<Service> services = [];
  List<double> discounts = [
    13,
    14,
  ];

  // final SlidableController slidableController = SlidableController();

  @override
  void initState() {
    super.initState();
    setState(() {
      services = [
        service,
        service,
        service,
      ];
      chargeWidgetList = _addServicesList();
    });
  }

  _removeService() {
    showBottomModal(
      bottomModalProps: BottomModalProps(
        context: context,
        centerTitle: true,
        primaryButtonText: 'Delete',
        secondaryButtonText: 'Back',
        deleteCancelModal: true,
        footerButton: ModalFooter.both,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIcon(
              customIconProps: CustomIconProps(
                icon: null,
                path: 'assets/icons/trash.png',
                withPadding: true,
                backgroundColor: Theme.of(context).colorScheme.error,
                iconColor: Colors.white,
                containerSize: rSize(80),
                contentPadding: rSize(20),
              ),
            ),
            SizedBox(
              height: rSize(30),
            ),
            Text(
              'Delete Service?',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: rSize(10),
            ),
            Text(
              'Action can not be undone',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _addServicesList() {
    List<Widget> widgetList = services.map((Service service) {
      return FadeAnimation(
        positionType: PositionType.top,
        delay: 0.5,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: rSize(5),
          ),
          child: CustomSlidable(
            customSlidableProps: CustomSlidableProps(
              groupTag: 'checkoutDetails',
              deleteAction: () => _removeService(),
              child: ServiceCard(
                serviceCardProps: ServiceCardProps(
                  serviceDetails: service,
                  title: service.name ?? '',
                  subTitle: getDateTimeFormat(
                      dateTime: service.startTime,
                      format: 'EEE, MMM dd, yyyy, HH:mm'),
                  withNavigation: false,
                  enabled: false,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();

    return widgetList;
  }

  _addItem() {
    RenderBox renderBox =
        addItemButtonKey.currentContext!.findRenderObject()! as RenderBox;
    final tapLocationOffset = renderBox.localToGlobal(Offset.zero);
    final Size buttonSize = renderBox.size;
    //Todo: Show the popup
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(seconds: 0),
        pageBuilder: (context, animation1, animation2) {
          return OverPopupPage(
            showOffset: tapLocationOffset,
            buttonSize: buttonSize,
            child: Row(
              children: [
                CustomTextButton(
                  customTextButtonProps: CustomTextButtonProps(
                    text: 'Service',
                    textColor: Theme.of(context).colorScheme.primary,
                    onTap: (() => {
                          Navigator.pop(context),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Services(
                                selectionMode: true,
                                onTap: () => {Navigator.pop(context)},
                              ),
                            ),
                          )
                          // Navigator.pushNamed(context, '/services', arguments: {
                          //   {selectionMode: true}
                          // }),
                        }),
                  ),
                ),
                VerticalDivider(
                  thickness: rSize(1),
                  width: rSize(40),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                CustomTextButton(
                  customTextButtonProps: CustomTextButtonProps(
                    text: 'Amount',
                    textColor: Theme.of(context).colorScheme.primary,
                    onTap: (() => {
                          Navigator.pop(context),
                          Navigator.pushNamed(context, '/amountSelection'),
                        }),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  _addService(Service service) {
    Widget serviceWidget = FadeAnimation(
      positionType: PositionType.top,
      delay: 0,
      child: ServiceCard(
        serviceCardProps: ServiceCardProps(
          serviceDetails: service,
          withNavigation: false,
          enabled: false,
          title: service.name ?? '',
          subTitle: service.duration ?? '',
        ),
      ),
    );
    chargeWidgetList.add(serviceWidget);
    setState(() {});
  }

  _addDiscount(String discount) {
    Widget discountWidget = FadeAnimation(
      positionType: PositionType.top,
      delay: 0,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(
          bottom: rSize(20),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            rSize(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(20),
            vertical: rSize(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Discount',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontSize: rSize(16),
                    ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    getStringPrice(10),
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          fontSize: rSize(16),
                        ),
                  ),
                  SizedBox(
                    height: rSize(2),
                  ),
                  Text(
                    discount,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    chargeWidgetList.add(discountWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _renderAmount(Service service) {
      return FadeAnimation(
        positionType: PositionType.top,
        delay: 1.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                EaseInAnimation(
                  key: addItemButtonKey,
                  onTap: () => {
                    _addItem(),
                  },
                  child: CustomIcon(
                    customIconProps: CustomIconProps(
                      iconColor: Theme.of(context).colorScheme.primary,
                      icon: null,
                      contentPadding: rSize(10),
                      withPadding: true,
                      path: 'assets/icons/plus.png',
                      containerSize: 35,
                    ),
                  ),
                ),
                SizedBox(
                  width: rSize(10),
                ),
                Text(
                  'Add Item',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  width: rSize(20),
                ),
                EaseInAnimation(
                  onTap: () => {
                    Navigator.pushNamed(context, '/discountSelection'),
                  },
                  child: CustomIcon(
                    customIconProps: CustomIconProps(
                      iconColor: Theme.of(context).colorScheme.primary,
                      icon: null,
                      withPadding: true,
                      path: 'assets/icons/percent.png',
                      containerSize: 35,
                    ),
                  ),
                ),
                SizedBox(
                  width: rSize(10),
                ),
                Text(
                  'Discount',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Total'.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  getStringPrice(50),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ],
        ),
      );
    }

    _renderFooter(Service service) {
      return FadeAnimation(
        positionType: PositionType.top,
        delay: 1,
        child: CustomButton(
          customButtonProps: CustomButtonProps(
            onTap: () => {},
            text: 'Continue',
            isPrimary: true,
            isSecondary: false,
          ),
        ),
      );
    }

    _appointmentServices() {
      List<Widget> widgetList = services.map((Service service) {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: rSize(5),
          ),
          height: rSize(18),
          child: Row(
            children: [
              VerticalDivider(
                color: service.color ?? Theme.of(context).colorScheme.primary,
                width: rSize(2),
                thickness: rSize(2),
              ),
              SizedBox(
                width: rSize(10),
              ),
              Text(
                service.name!,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        );
      }).toList();

      return widgetList;
    }

    _renderClient(Contact? contact) {
      return contact == null
          ? EaseInAnimation(
              beginAnimation: 0.99,
              onTap: () => {Navigator.pushNamed(context, '/contacts')},
              child: DottedBorder(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                borderType: BorderType.RRect,
                dashPattern: [rSize(6), rSize(4)],
                strokeWidth: rSize(1),
                radius: Radius.circular(
                  rSize(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: rSize(20),
                    vertical: rSize(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAvatar(
                        customAvatarProps: CustomAvatarProps(
                          enable: false,
                          circleShape: true,
                        ),
                      ),
                      SizedBox(
                        width: rSize(15),
                      ),
                      Expanded(
                        child: Text(
                          'Select a client or leave empty for walk-in',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      SizedBox(
                        width: rSize(10),
                      ),
                      IconTheme(
                        data: Theme.of(context).primaryIconTheme,
                        child: Icon(
                          Icons.chevron_right,
                          size: rSize(25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ContactCard(
              contactCardProps: ContactCardProps(
                contactDetails: Contact(
                  name: 'Ahmad Manaa',
                  phone: '0505800955',
                ),
              ),
            );
    }

    _renderAppointment() {
      return Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rSize(20),
            vertical: rSize(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    getDateTimeFormat(
                        dateTime: kToday, format: 'EEEE', isDayOfWeek: true),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    getDateTimeFormat(dateTime: kToday, format: 'dd'),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    getDateTimeFormat(dateTime: kToday, format: 'HH:mm'),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                width: rSize(20),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _appointmentServices(),
                    ),
                    SizedBox(
                      width: rSize(50),
                    ),
                    Column(
                      children: [
                        CustomStatus(
                          customStatusProps: CustomStatusProps(
                            status: Status.confirmed,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: rSize(5),
                        ),
                        Text(
                          'ID: ${service.id!}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return CloseSlidableOnTap(
      child: Scaffold(
        appBar: CustomAppBar(
          customAppBarProps: CustomAppBarProps(
            titleText: 'Checkout',
            withBack: true,
            barHeight: 100,
            withClipPath: true,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          top: false,
          left: false,
          right: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: rSize(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: rSize(20),
                      ),
                      FadeAnimation(
                        delay: 0,
                        child: _renderClient(null),
                      ),
                      SizedBox(
                        height: rSize(20),
                      ),
                      FadeAnimation(
                        delay: 0.3,
                        child: _renderAppointment(),
                      ),
                      SizedBox(
                        height: rSize(20),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: chargeWidgetList,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: rSize(20),
                      ),
                      _renderAmount(service),
                      SizedBox(
                        height: rSize(10),
                      ),
                      _renderFooter(service),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
