import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MessageController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'แจ้งเตือนทั่วไป',
      'แจ้งเตือน สำคัญ',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      badgeNumber: 4,
      subtitle: "รายละเอียด",
    );
    const NotificationDetails platformChannelDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'ทดสอบ',
      'My Message',
      platformChannelDetails,
    );
  }
}
