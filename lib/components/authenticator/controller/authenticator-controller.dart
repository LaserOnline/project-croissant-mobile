import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';

class AuthenticatorController extends GetxController {
  Rx<int> keyNumber = Rx(256863);
  Rx<int> second = Rx(30);
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    countdown();
  }

  @override
  void onClose() {
    timer?.cancel();
    keyNumber.close();
    second.close();
    super.onClose();
  }

  countdown() async {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (second.value > 0) {
        second.value--;
      } else {
        second.value = 30;
        keyNumber.value = generateRandomKeyNumber();
      }
    });
  }

  int generateRandomKeyNumber() {
    Random random = Random();
    return random.nextInt(900000) + 100000;
  }
}
