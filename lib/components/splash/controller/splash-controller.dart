import 'package:app_croissant/module/model/users.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../module/api/api-service.dart';
import '../../../module/core/secure-storage/secure-storage.dart';
import '../../../module/core/storage/storage.dart';
import '../../../module/shared/users.shared.dart';

class SplashController extends GetxController {
  final storageService = Get.put(StorageService());
  final apiServer = Get.find<ApiServer>();
  final secureStorage = SecureStorage();
  final userController = Get.find<UsersShared>();
  bool login = false;
  bool pin = false;

  @override
  void onInit() async {
    super.onInit();
    await initializeApp();
    await Permission.notification.request();
  }

  initializeApp() async {
    Future.delayed(const Duration(seconds: 3), () async {
      pin = storageService.getEnablePin();
      login = await secureStorage.hasTokens();
      if (pin) {
        await sendToken();
        Get.offAllNamed('/pin');
      } else {
        if (login) {
          await sendToken();
          Get.offAllNamed('/app');
        } else {
          Get.offAllNamed('login');
        }
      }
    });
  }

  sendToken() async {
    await apiServer.userInfo().then((response) {
      var user = UserInfo.fromJson(response.data as Map<String, dynamic>);
      userController.setUserInfo(user);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        if (error.response != null) {
          if (error.response?.statusCode == 400) {
            // secureStorage.clearTokenData();
            // userController.userInfo.close();
          } else if (error.response?.statusCode == 403) {
            // Get.log('statusCode ${error.response?.statusCode}');
            // userController.userInfo.close();
            // secureStorage.clearTokenData();
            Get.log("HelloWorld");
          }
        } else {
          Get.log("No response received");
        }
      }
    }).whenComplete(() {});
  }

  @override
  void onClose() {
    super.onClose();
    storageService.dispose();
  }
}
