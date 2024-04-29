import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_storage/get_storage.dart';

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
final box = GetStorage();

Future<void> devicesInfo() async {
  try {
    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      addStorageDevices('android', {
        'model': androidInfo.model,
        'brand': androidInfo.board,
        'device': androidInfo.device,
        'version': androidInfo.version.release,
      });
    } else if (GetPlatform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      addStorageDevices('IOS', {
        'model': iosInfo.model,
        'brand': 'Apple',
        'device': iosInfo.name,
        'version': iosInfo.utsname.version,
      });
    } else {
      Get.log("device support");
    }
  } catch (e) {
    Get.log("001 ${e}");
  }
}

Future<Map<String, dynamic>> getDeviceINFO() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> device = {};

  if (GetPlatform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    device = {
      'device_model': androidInfo.model,
      'device_brand': androidInfo.board,
      'device_name': androidInfo.device,
      'device_version': androidInfo.version.release,
    };
  } else if (GetPlatform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
    device = {
      'device_model': iosInfo.model.toString(),
      'device_brand': 'IOS',
      'device_name': iosInfo.name.toString(),
      'device_version': iosInfo.systemVersion.toString(),
    };
  }

  return device;
}

void addStorageDevices(String os, Map<String, String> details) {
  box.write(os, details);
}
