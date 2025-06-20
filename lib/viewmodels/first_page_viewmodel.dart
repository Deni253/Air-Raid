import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class FirstPageViewModel extends ChangeNotifier {
  double profile = 0;
  double ninety = 0;
  double seventy = 0;

  void startAnimation() {
    Future.delayed(Duration(milliseconds: 700), () {
      profile = 5;
      ninety = 90;
      seventy = 70;
      notifyListeners();
    });
  }

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

  Future<void> scheduleDailyNotificationAt21h() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 21,
        channelKey: 'reminder_channel',
        title: 'Vrijeme za let! ✈️',
        body: 'Ne zaboravi odigrati Air-Raid večeras!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        hour: 22,
        minute: 0,
        second: 0,
        repeats: true,
        preciseAlarm: true,
        allowWhileIdle: true,
      ),
    );
  }
}
