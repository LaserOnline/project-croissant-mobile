import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class OTPController extends GetxController {
  Timer? timer;
  RxList<int> data = RxList();
  Rx<String> logError = RxString('');
  Rx<bool> loading = Rx(false);
  Rx<int> seconds = Rx(60);
  RxList<bool> enableField = RxList<bool>.filled(4, true);
  List<TextEditingController> otpFieldControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void onInit() {
    super.onInit();
    startEnableField();
    test();
  }

  @override
  void onClose() {
    super.onClose();
    data.close();
    logError.close();
    loading.close();
    seconds.close();
    for (var controller in otpFieldControllers) {
      controller.dispose();
    }
    enableField.close();
    timer?.cancel();
  }

  void startEnableField() {
    enableField[0] = false;
  }

  void test() async {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        seconds.value = 60;
      }
    });
  }

  void addData(int value, int index) async {
    if (data.length < 4) {
      data.add(value);
      setEnableField(data.length);
      if (data.length == 4) {
        await Future.delayed(
            const Duration(
              seconds: 1,
            ), () async {
          submit();
        });
        Get.log(data.string);
      }
    }
  }

  void setEnableField(int index) {
    for (var i = 0; i < enableField.length; i++) {
      if (i == index) {
        Get.log("enable Field ${enableField[i]}");
        enableField[i] = false;
      }

      if (i != index) {
        enableField[i] = true;
      }
    }
  }

  void clearOTPFields() {
    for (var controller in otpFieldControllers) {
      controller.clear();
    }
    data.clear();
  }

  void setLogError(String value) {
    logError.value = value;
  }

  submit() async {
    loading.value = true;
    try {
      setLogError("Success");

      await Future.delayed(const Duration(seconds: 5), () async {
        clearOTPFields();
        startEnableField();
      });
      Get.offAllNamed('/splash');
    } catch (err) {
      Get.log("error ${err}");
    } finally {
      Get.log("loading successfully");
      loading.value = false;
      Get.log(loading.value.toString());
    }
  }

  failed() async {
    data.clear();
  }

  void clearLogTextError() {
    logError.value = "";
  }
}
