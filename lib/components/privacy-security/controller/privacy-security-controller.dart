import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PrivacySecurityController extends GetxController {
  Rx<bool> statusNotification = Rx(false);
  @override
  void onInit() {
    super.onInit();
    checkNotificationPermission();
  }

  void checkNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isGranted) {
      statusNotification.value = true;
    } else {
      statusNotification.value = false;
    }
  }

  void requestNotification(bool value) async {
    var status = await Permission.notification.status;

    if (!status.isGranted) {
      var enable = await Permission.notification.request();
      statusNotification.value = value;
      statusNotification.value = enable.isGranted;
    } else {}
  }
}
