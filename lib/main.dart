import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  runApp(MyApp());

  // Initialize the plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Configure the notification settings
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Schedule the first notification immediately
  await _scheduleNotification(flutterLocalNotificationsPlugin, 0);

  // Schedule periodic notifications every 10 minutes
  Timer.periodic(const Duration(seconds: 30), (timer) {
    _scheduleNotification(flutterLocalNotificationsPlugin, timer.tick);
  });
}

Future<void> _scheduleNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, int times) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id', // Change this to a unique channel ID
    'Your Channel Name', // Change this to a channel name
    channelDescription: 'Your Channel Description', // Change this to a channel description
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  // Create the notification
  await flutterLocalNotificationsPlugin.show(
    0, // Change this to a unique ID for each notification
    'Your Notification Title $times',
    'Your Notification Body',
    platformChannelSpecifics,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Periodic notification")),
        body: const Center(child: Text("Notification")),
      ),
    );
  }
}
