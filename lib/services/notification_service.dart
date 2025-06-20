import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

Future<void> initializeAwesomeNotifications() async {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'reminder_channel',
      channelName: 'Reminders',
      channelDescription: 'Notification channel for reminders',
      defaultColor: Colors.blue,
      ledColor: Colors.white,
      importance: NotificationImportance.High,
    ),
  ], debug: true);

  final isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
}
