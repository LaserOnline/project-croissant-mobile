import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../module/api/api-service.dart';
import '../../../module/core/secure-storage/secure-storage.dart';
import '../../../module/model/token.model.dart';

class LoginController extends GetxController {
  final secureStorage = SecureStorage();
  final apiServer = Get.find<ApiServer>();
  final Rx<TextEditingController> usernameController =
      TextEditingController().obs;
  var isUsernameNotEmpty = false.obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;
  var isPasswordNotEmpty = false.obs;
  Rx<bool> enablePassword = true.obs;
  RxString logErrUsername = RxString('');
  RxString logErrPassword = RxString('');
  Rx<bool> loading = Rx(false);
  Rx<String> responseError = Rx('');
  @override
  void onInit() {
    Get.log("LoginController: onInit");
    usernameController.value.addListener(() {
      isUsernameNotEmpty.value = usernameController.value.text.isNotEmpty;
      logErrUsername.value = "";
    });
    passwordController.value.addListener(() {
      isPasswordNotEmpty.value = passwordController.value.text.isNotEmpty;
      logErrPassword.value = "";
    });
    super.onInit();
  }

  void onClose() {
    Get.log("LoginController: onClose");
    responseError.close();
    usernameController.close();
    passwordController.close();
    enablePassword.close();
    logErrUsername.close();
    logErrPassword.close();
    loading.close();
    super.onClose();
  }

  void submit(String usernameController, String passwordController) async {
    String username = usernameController.replaceAll(" ", "");
    String password = passwordController.replaceAll(" ", "");
    RegExp specialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (username.isEmpty) {
      logErrUsername.value = "กรุณากรอง ผู้ใช้งาน";
      logErrPassword.value = "";
    } else if (specialChars.hasMatch(username)) {
      logErrUsername.value = "ไม่สามาใช้ตัวอักษรพิเศษได้";
      logErrPassword.value = "";
    } else if (password.isEmpty) {
      logErrPassword.value = "กรุณากรองรหัสผ่าน";
      logErrUsername.value = "";
    } else if (specialChars.hasMatch(password)) {
      logErrPassword.value = "ไม่สามาใช้ตัวอักษรพิเศษได้";
      logErrUsername.value = "";
    } else {
      try {
        loading.value = true;
        apiServer.login(username, password).then((res) async {
          var loginModel = GetToken.fromJson(res.data);
          await secureStorage.storeLoginData(loginModel);
          Get.offAllNamed('/splash');
        }).onError((error, stackTrace) {
          if (error is DioException) {
            if (error.response != null) {
              if (error.response?.statusCode == 400) {
                Get.log("Status code: ${error.response!.statusCode}");
                responseError.value = error.response!.data['message'];
              } else if (error.response!.statusCode == 500) {
                Get.log("Status code: ${error.response!.statusCode}");
                responseError.value =
                    "Internal Server Error. Please try again later.";
              }
            } else {
              Get.log("No response received");
              responseError.value =
                  "Network error. Please check your connection.";
            }
          } else {
            Get.log("Non-DioException Error: $error");
          }
        });
      } finally {
        loading.value = false;
      }
    }
  }

  void clearController() {
    logErrUsername.value = "";
    logErrPassword.value = "";
    usernameController.value.clear();
    passwordController.value.clear();
  }

  void hinPassword() {
    if (enablePassword.value == true) {
      enablePassword.value = false;
    } else {
      enablePassword.value = true;
    }
    Get.log("show ${enablePassword.value}");
  }
}
