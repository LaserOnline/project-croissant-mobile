import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../module/core/storage/storage.dart';

class PinController extends GetxController {
  final storageService = Get.put(StorageService());
  final LocalAuthentication auth = LocalAuthentication();
  Rx<String> title = Rx('');
  Rx<int> count = Rx(0);
  Rx<int> countPin = Rx(0);
  RxList<int> pinNumber = RxList();
  RxList<int> pinNumberOld = RxList();
  Rx<bool> statusPinMode = Rx(false);
  Rx<String> imageApp = Rx('assets/icons/lock.png');
  Rx<bool> supportFaceID = Rx(false);
  bool status = false;
  @override
  void onInit() {
    super.onInit();
    initVariables();
    checkForFaceID();
    update();
  }

  @override
  void dispose() {
    super.dispose();
    supportFaceID.close();
    count.close();
    countPin.close();
    pinNumber.close();
    pinNumberOld.close();
    statusPinMode.close();
    imageApp.close();
  }

  setup(bool value) {
    status = value;
    if (status) {
      title.value = "Set Pin";
      statusPinMode.value = status;
    } else {
      title.value = "Enter Pin";
    }
  }

  checkForFaceID() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.contains(BiometricType.face)) {
      supportFaceID.value = true;
      Get.log("----> support");
    } else {
      Get.log("----> no");
      supportFaceID.value = false;
    }
  }

  authFaceID() async {
    bool isAuthenticated = false;
    try {
      bool canAuthenticateWithFace = await auth.canCheckBiometrics &&
          (await auth.getAvailableBiometrics()).contains(BiometricType.face);
      if (canAuthenticateWithFace) {
        isAuthenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to access this feature',
          options: const AuthenticationOptions(biometricOnly: true),
        );
        Get.log("true");
      }
    } catch (e) {
      Get.log("An error occurred during authentication: $e");
    }
    Get.log(isAuthenticated ? 'true' : 'false');
  }

  void initVariables() {
    title.value = '';
    count.value = 0;
    countPin.value = 0;
    pinNumber.clear();
    pinNumberOld.clear();
    statusPinMode.value = false;
    imageApp.value = 'assets/icons/lock.png';
    status = false;
  }

  void setPin(int value) {
    if (pinNumber.length < 4) {
      pinNumber.add(value);
      countPin.value = pinNumber.length;
      update(['pinNumber']);

      if (pinNumber.length == 4) {
        if (statusPinMode.value == true) {
          count.value++;
          update(['count']);

          if (count.value == 1) {
            pinNumberOld.assignAll(pinNumber);
            pinNumber.clear();
            countPin.value = 0;
            title.value = "Confirm Again";
            update(['pinNumber', 'title', 'pinNumberOld']);
          } else if (count.value == 2) {
            if (listEquals(pinNumberOld, pinNumber)) {
              storageService.writePin(pinNumber.toList());
              storageService.setupPin();
              storageService.enablePin();
              title.value = "Success";
              delayedFunction(() => Get.back());
              update(['title']);
            } else {
              count.value = 0;
              countPin.value = 0;
              title.value = "Failed";
              pinNumberOld.clear();
              pinNumber.clear();
              update(['title', 'count', 'pinNumber', 'pinNumberOld']);
            }
          }
        } else {
          validatePin(pinNumber.toList());
        }
      }
    } else {
      storageService.showPin();
    }
  }

  void popPin() {
    if (pinNumber.length > 0) {
      pinNumber.removeLast();
      countPin.value--;
      update(['pinNumber', 'title', 'pinNumberOld']);
    }
  }

  void delayedFunction(VoidCallback event) async {
    Get.log('Delaying...');
    await Future.delayed(const Duration(seconds: 1));
    event();
  }

  validatePin(List value) async {
    List data = storageService.getPin();
    if (listEquals(value, data)) {
      title.value = "Success";
      imageApp.value = "assets/icons/lock-open-alt.png";
      delayedFunction(() => Get.offAllNamed('/app'));
      onClose();
    } else {
      count.value++;
      title.value = "Failed";
      await Future.delayed(const Duration(seconds: 1));
      countPin.value = 0;
      pinNumber.clear();
      Get.log(count.value.toString());
      update(['count', 'title', 'countPin', 'pinNumber']);
    }
  }

  void clearPin() {
    storageService.clearPin();
  }
}
