import 'package:flutter_background_service/flutter_background_service.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: false,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  onIosBackground(service);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  Timer? timer;
  service.on('stopService').listen((event) {
    timer?.cancel();
    Get.log("cancel");
    service.stopSelf();
  });

  if (Platform.isAndroid) {
    service.on('setAsForeground').listen((event) {});
  }
  if (Platform.isIOS) {
    service.on('setAsBackground').listen((event) {});
  }
  service.on('startService').listen((event) {
    timer?.cancel();
    Get.log("Service started");

    int seconds = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      seconds++;
      Get.log("Background service running for ${seconds} seconds");
      service.invoke('update', {"seconds": seconds});
    });
  });
}
