import 'package:appointments/data_types/macros.dart';
import 'package:appointments/localization/language/languages.dart';
import 'package:appointments/providers/appointments_mgr.dart';
import 'package:appointments/providers/auth_mgr.dart';
import 'package:appointments/providers/clients_mgr.dart';
import 'package:appointments/screens/home/appointments/appointment_details.dart';
import 'package:appointments/screens/home/clients/clients.dart';
import 'package:appointments/screens/home/more.dart';
import 'package:appointments/screens/home/notification/approval_request.dart';
import 'package:appointments/screens/home/notification/notifications.dart';
import 'package:appointments/screens/home/timeline.dart';
import 'package:common_widgets/custom_button_widget.dart';
import 'package:common_widgets/custom_icon.dart';
import 'package:common_widgets/custom_modal.dart';
import 'package:common_widgets/utils/general.dart';
import 'package:common_widgets/utils/layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../providers/notifications_mgr.dart';

// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Message {
  String title;
  String body;
  String message;
  Message(this.title, this.body, this.message);
}

class _HomeScreenState extends State<HomeScreen> {
  ///********************** Notifications handler **********************///
  //FCM instance
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late AuthenticationMgr authMgr;
  late AppointmentsMgr appointmentsMgr;
  late ClientsMgr clientsMgr;
  late NotificationsMgr notificationsMgr;

  _requestIOSNotificationPermissions() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   print('User granted permission: ${settings.authorizationStatus}');
    // } else if(settings.authorizationStatus == AuthorizationStatus.provisional) {
    //   print('User granted provisional permission: ${settings.authorizationStatus}');
    // } else {
    //   print('User declined permission: ${settings.authorizationStatus}');
    // }

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  _getToken() {
    _messaging.getToken().then((token) {
      // Save in database
      if (token != null) {
        authMgr.saveToken(token);
      }
    });

    // Any time the token refreshes, store this in the database too.
    _messaging.onTokenRefresh.listen(authMgr.saveToken);
  }

  Future<dynamic> onSelectNotification(
      NotificationResponse notificationResponse) async {
    await notificationsMgr.markNotificationOpened(
        notificationResponse.payload, authMgr.getLoggedInAdminEmail());
    String notificationType = await notificationsMgr.getNotificationType(
        notificationResponse.payload, authMgr.getLoggedInAdminEmail());

    // Assuming application data has already been updated with selected appointment
    // handle notification selection
    if (notificationType == NotificationCategory.appointment.toString()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AppointmentDetails()));
    }
    if (notificationType == NotificationCategory.user.toString()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ApprovalRequest()));
    }
  }

  _initializeNotification() async {
    /// Foreground messages handler
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        if (message.data.isNotEmpty) {
          if (message.data['category'] ==
              NotificationCategory.appointment.toString()) {
            String appointmentId = message.data['appointment_id'];
            await appointmentsMgr.setSelectedAppointment(
                appointmentID: appointmentId);
          }
          if (message.data['category'] ==
              NotificationCategory.user.toString()) {
            String clientId = message.data['client_id'];
            await clientsMgr.setSelectedClient(clientID: clientId);
          }
        }
        if (message.notification != null) {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;

          // If `onMessage` is triggered with a notification, construct our own
          // local notification to show to users using the created channel.
          if (notification != null && android != null) {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: android.smallIcon,
                  setAsGroupSummary: true,
                  color: const Color(0xFF117050),
                ),
                iOS: const DarwinNotificationDetails(
                  presentAlert: true,
                  presentSound: true,
                ),
              ),
              payload: message.data['notification_id'],
            );
          }
        }
      },
    );

    /// Activated on background only
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if (message.data['category'] ==
          NotificationCategory.appointment.toString()) {
        String appointmentId = message.data['appointment_id'];
        await appointmentsMgr.setSelectedAppointment(
            appointmentID: appointmentId);
        onSelectNotification(NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotification,
            payload: message.data['notification_id']));
      }
      if (message.data['category'] == NotificationCategory.user.toString()) {
        String clientId = message.data['client_id'];
        await clientsMgr.setSelectedClient(clientID: clientId);
        onSelectNotification(NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotification,
            payload: message.data['notification_id']));
      }
    });

    /// Activated on terminated only
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        if (message.data['category'] ==
            NotificationCategory.appointment.toString()) {
          String appointmentId = message.data['appointment_id'];
          await appointmentsMgr.setSelectedAppointment(
              appointmentID: appointmentId);
          onSelectNotification(NotificationResponse(
              notificationResponseType:
                  NotificationResponseType.selectedNotification,
              payload: message.data['notification_id']));
        }
        if (message.data['category'] == NotificationCategory.user.toString()) {
          String clientId = message.data['client_id'];
          await clientsMgr.setSelectedClient(clientID: clientId);
          onSelectNotification(NotificationResponse(
              notificationResponseType:
                  NotificationResponseType.selectedNotification,
              payload: message.data['notification_id']));
        }
      }
    });
  }

  _init() async {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'Delivery app - packages status', // description
      importance: Importance.max,
      playSound: true,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable
    /// heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/transparent2');
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onSelectNotification);
  }

  ///******************************************************************///
  @override
  void initState() {
    super.initState();
    authMgr = Provider.of<AuthenticationMgr>(context, listen: false);
    appointmentsMgr = Provider.of<AppointmentsMgr>(context, listen: false);
    clientsMgr = Provider.of<ClientsMgr>(context, listen: false);
    notificationsMgr = Provider.of<NotificationsMgr>(context, listen: false);
    _init();
    _requestIOSNotificationPermissions();
    _getToken();
    _initializeNotification();
  }

  int _selectedPage = 0;
  final screens = [
    TimeLine(),
    Clients(),
    Notifications(),
    More(),
  ];

  Widget getModalBody() {
    return Column(
      children: [
        SizedBox(
          height: rSize(10),
        ),
        CustomButton(
          customButtonProps: CustomButtonProps(
            onTap: () => {
              Navigator.pop(context),
              Navigator.of(context).pushNamed('/newAppointment'),
            },
            text: Languages.of(context)!.newAppointmentLabel.toTitleCase(),
          ),
        ),
        SizedBox(
          height: rSize(10),
        ),
        CustomButton(
          customButtonProps: CustomButtonProps(
            onTap: () => {
              Navigator.pop(context),
              Navigator.of(context).pushNamed('/unavailability'),
            },
            text: Languages.of(context)!.unavailabilityLabel.toTitleCase(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedPage],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: rSize(60),
        height: rSize(60),
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              showBottomModal(
                bottomModalProps: BottomModalProps(
                  context: context,
                  child: getModalBody(),
                  showDragPen: true,
                  enableDrag: true,
                ),
              );
            },
            elevation: 4.0,
            child: const Icon(Icons.add),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: rSize(5),
        shape: const CircularNotchedRectangle(),
        child: Container(
          margin: EdgeInsets.fromLTRB(
            rSize(20),
            rSize(10),
            rSize(20),
            !isDeviceHasNotch(context)
                ? rSize(20)
                : isAndroid()
                    ? rSize(20)
                    : 0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIcon(
                customIconProps: CustomIconProps(
                  isDisabled: false,
                  onTap: () {
                    setState(() {
                      _selectedPage = 0;
                    });
                  },
                  iconColor: _selectedPage == 0
                      ? darken(Theme.of(context).colorScheme.secondary, 0.2)
                      : Theme.of(context).colorScheme.primary,
                  icon: null,
                  backgroundColor: Colors.transparent,
                  path: 'assets/icons/calendar_full.png',
                  withPadding: true,
                  contentPadding: 1,
                  containerSize: 35,
                ),
              ),
              CustomIcon(
                customIconProps: CustomIconProps(
                  isDisabled: false,
                  onTap: () {
                    setState(() {
                      _selectedPage = 1;
                    });
                  },
                  iconColor: _selectedPage == 1
                      ? darken(Theme.of(context).colorScheme.secondary, 0.2)
                      : Theme.of(context).colorScheme.primary,
                  icon: null,
                  backgroundColor: Colors.transparent,
                  path: 'assets/icons/contacts.png',
                  withPadding: true,
                  contentPadding: 0,
                  containerSize: 35,
                ),
              ),
              SizedBox(
                width: rSize(80),
              ),
              CustomIcon(
                customIconProps: CustomIconProps(
                  isDisabled: false,
                  onTap: () {
                    setState(() {
                      _selectedPage = 2;
                    });
                  },
                  iconColor: _selectedPage == 2
                      ? darken(Theme.of(context).colorScheme.secondary, 0.2)
                      : Theme.of(context).colorScheme.primary,
                  icon: null,
                  backgroundColor: Colors.transparent,
                  path: 'assets/icons/bell_full.png',
                  withPadding: true,
                  contentPadding: 2,
                  containerSize: 35,
                ),
              ),
              CustomIcon(
                customIconProps: CustomIconProps(
                  isDisabled: false,
                  onTap: () {
                    setState(() {
                      _selectedPage = 3;
                    });
                  },
                  iconColor: _selectedPage == 3
                      ? darken(Theme.of(context).colorScheme.secondary, 0.2)
                      : Theme.of(context).colorScheme.primary,
                  icon: null,
                  backgroundColor: Colors.transparent,
                  path: 'assets/icons/more.png',
                  withPadding: true,
                  contentPadding: 2,
                  containerSize: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
