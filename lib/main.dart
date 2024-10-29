import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:json_theme/json_theme.dart';
import 'views/Services/echec.dart';
import 'views/Services/success.dart';
import 'views/accueil.dart';
import 'views/first_page.dart';
import 'views/login/login.dart';
import 'views/school_choice.dart';
import 'widgets/event_pref.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'widgets/root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('logo');
  DarwinInitializationSettings initializationSettingsDarwin =
      const DarwinInitializationSettings();
  LinuxInitializationSettings initializationSettingsLinux =
      const LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Create the notification channel
  await _createNotificationChannel();

  StreamSubscription? _sub;

  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  final darkThemeStr = await rootBundle.loadString('assets/darktheme.json');
  final darkThemeJson = jsonDecode(darkThemeStr);
  final darkTheme = ThemeDecoder.decodeThemeData(darkThemeJson)!;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp(
        theme: theme,
        darkTheme: darkTheme,
      )));
  runApp(MyApp(theme: theme, darkTheme: darkTheme));

}
void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
  }
  // await Navigator.push(
  //   context,
  //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  // );
}

Future<void> _createNotificationChannel() async {
  const channel = AndroidNotificationChannel(
    'your_channel_id',
    'Your Channel Name',
    importance: Importance.max,
    playSound: true,
  );

  // Create the notification channel
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}


class MyApp extends StatelessWidget {
  final ThemeData theme;
  final ThemeData darkTheme;
  const MyApp({super.key, required this.theme, required this.darkTheme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: EventPref.getUser(),
          builder: (context, snapshot) {
            if (snapshot.data == null) return const Login();
            return const FirstPage();
          }),
    );
  }
}
