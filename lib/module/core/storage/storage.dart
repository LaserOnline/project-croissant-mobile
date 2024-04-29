import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void writePin(List data) {
    box.write('otp', data);
  }

  getPin() {
    List data = [];
    data = box.read('otp');
    return data;
  }

  getStatusPin() {
    bool value = false;
    if (box.hasData('setupPin')) {
      value = box.read('setupPin');
    }
    return value;
  }

  getEnablePin() {
    bool value = false;
    if (box.hasData('statusPin')) {
      value = box.read('statusPin');
    }
    return value;
  }

  void setupPin() {
    box.write('setupPin', true);
  }

  void enablePin() {
    box.write('statusPin', true);
  }

  void disablePin() {
    box.write('statusPin', false);
  }

  void clearPin() {
    GetStorage().remove('otp');
  }

  void showPin() {
    List data = box.read('otp');
    Get.log("Storage OTP: ${data.join(' ')}");
  }

  void removeAll() {}
}
