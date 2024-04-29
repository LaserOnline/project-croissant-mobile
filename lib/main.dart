import 'package:app_croissant/module/core/background-service/background-service.dart';
import 'package:app_croissant/module/core/info-device/info-device.dart';
import 'package:app_croissant/module/router/router.dart';
import 'package:app_croissant/module/shared/users.shared.dart';
import 'package:app_croissant/module/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'module/api/api-service.dart';
import 'module/core/permission/permission.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: initializationSettingsDarwin,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await GetStorage.init();
  await devicesInfo();
  await initializeService();
  Get.put(UsersShared());
  Get.put(ApiServer());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: 'App Croissant',
        theme: configTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash',
        getPages: AppRouter.router,
      );
    });
  }
}
