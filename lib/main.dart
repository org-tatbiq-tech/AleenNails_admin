import 'package:appointments/data_types.dart';
import 'package:appointments/screens/home/home.dart';
import 'package:appointments/screens/landing/landing.dart';
import 'package:appointments/screens/login/login.dart';
import 'package:appointments/screens/register/register.dart';
import 'package:appointments/widget/custom_app_bar.dart';
import 'package:appointments/widget/custom_liquid_swipe.dart';
import 'package:appointments/widget/ease_in_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'providers/theme_provider.dart';

void main() {
  runApp(const MyApp());

  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Consumer<ThemeNotifier>(builder: (context, theme, child) {
        return MaterialApp(
          builder: (context, _) {
            var child = _!;
            return child;
          },
          theme: theme.getTheme(),
          home: const MyHomePage(),
        );
      });
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: CustomAppBar(
      //   customAppBarProps: CustomAppBarProps(
      //     withSearch: true,
      //     leadingWidget: EaseInAnimation(
      //       onTap: () => {
      //         print(
      //             "Device Width: ${Device.width}, Device Height: ${Device.height}")
      //       },
      //       child: IconTheme(
      //         data: Theme.of(context).primaryIconTheme,
      //         child: const Icon(
      //           Icons.menu,
      //         ),
      //       ),
      //     ),
      //     customIcon: IconTheme(
      //       data: Theme.of(context).primaryIconTheme,
      //       child: const Icon(
      //         Icons.more_vert,
      //       ),
      //     ),
      //   ),
      // ),
      body: RegisterScreen(),
    );
  }
}
