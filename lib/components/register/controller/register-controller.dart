import 'package:app_croissant/module/model/token.model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../module/api/api-service.dart';
import '../../../module/core/secure-storage/secure-storage.dart';

class RegisterController extends GetxController {
  final secureStorage = SecureStorage();
  final apiServer = Get.find<ApiServer>();
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> usernameController =
      TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;
  final Rx<TextEditingController> passwordVerificationController =
      TextEditingController().obs;
  var isEmailNotEmpty = false.obs;
  var isUsernameNotEmpty = false.obs;
  var isPasswordNotEmpty = false.obs;
  var isPasswordVerificationNotEmpty = false.obs;
  RxString logErrEmail = RxString('');
  RxString logErrUsername = RxString('');
  RxString logErrPassword = RxString('');
  RxString logErrPasswordVerification = RxString('');
  RxString response = RxString('');
  RxBool loading = RxBool(false);
  @override
  void onInit() {
    emailController.value.addListener(() {
      isEmailNotEmpty.value = emailController.value.text.isNotEmpty;
      logErrEmail.value = "";
    });
    usernameController.value.addListener(() {
      isUsernameNotEmpty.value = usernameController.value.text.isNotEmpty;
      logErrUsername.value = "";
    });
    passwordController.value.addListener(() {
      isPasswordNotEmpty.value = passwordController.value.text.isNotEmpty;
      logErrPassword.value = "";
    });
    passwordVerificationController.value.addListener(() {
      isPasswordVerificationNotEmpty.value =
          passwordVerificationController.value.text.isNotEmpty;
      logErrPasswordVerification.value = "";
    });
    super.onInit();
  }

  @override
  void onClose() {
    Get.log("Register OnClose");
    usernameController.close();
    emailController.close();
    passwordController.close();
    passwordVerificationController.close();
    logErrUsername.close();
    logErrEmail.close();
    logErrPassword.close();
    logErrPasswordVerification.close();
    response.close();
    loading.close();
    super.onClose();
  }

  void submit(String username, String email, String pass,
      String passVerification) async {
    RegExp specialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (username.isEmpty) {
      logErrUsername.value = "กรุณากรอง username";
      logErrEmail.value = "";
      logErrPassword.value = "";
      logErrPasswordVerification.value = "";
      response.value = "";
    } else if (specialChars.hasMatch(username)) {
      logErrUsername.value = "ไม่สามาใช้ตัวอักษรพิเศษได้";
      logErrEmail.value = "";
      logErrPassword.value = "";
      logErrPasswordVerification.value = "";
      response.value = "";
    } else if (username.length < 5) {
      logErrUsername.value = "ตัวอักษร จะต้องมากกว่า 4";
      logErrEmail.value = "";
      logErrPassword.value = "";
      logErrPasswordVerification.value = "";
      response.value = "";
    } else if (email.isEmpty) {
      logErrEmail.value = "กรุณากรอง email";
      logErrUsername.value = "";
      logErrPassword.value = "";
      logErrPasswordVerification.value = "";
      response.value = "";
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      logErrEmail.value = "รูปแบบอีเมลไม่ถูกต้อง";
      logErrUsername.value = "";
      logErrPassword.value = "";
      logErrPasswordVerification.value = "";
      response.value = "";
    } else if (pass.isEmpty) {
      logErrPassword.value = "กรุณากรอง รหัสผ่าน";
      logErrPasswordVerification.value = "";
      logErrUsername.value = "";
      logErrEmail.value = "";
      response.value = "";
    } else if (pass.length < 8) {
      logErrPassword.value = "รหัสผ่านจะต้องไม่ต่ำกว่า 8";
      logErrPasswordVerification.value = "";
      logErrUsername.value = "";
      logErrEmail.value = "";
      response.value = "";
    } else if (passVerification.isEmpty) {
      logErrPasswordVerification.value = "กรุณากรอง ยืนยัน รหัสผ่าน";
      logErrPassword.value = "";
      logErrUsername.value = "";
      logErrEmail.value = "";
      response.value = "";
    } else if (passVerification != pass) {
      logErrPasswordVerification.value = "รหัสผ่านไม่ตรงกัน";
      logErrPassword.value = "";
      logErrUsername.value = "";
      logErrEmail.value = "";
      response.value = "";
    } else {
      response.value = "";
      loading.value = true;

      apiServer
          .register(username, email, pass, passVerification)
          .then((res) async {
        var loginModel = GetToken.fromJson(res.data);
        await secureStorage.storeLoginData(loginModel);
        Get.offAllNamed('/splash');
      }).onError((error, stackTrace) {
        if (error is DioException) {
          if (error.response != null) {
            if (error.response?.statusCode == 400) {
              Get.log("Status code: ${error.response!.statusCode}");
              response.value = error.response!.data['message'];
            } else if (error.response!.statusCode == 500) {
              Get.log("Status code: ${error.response!.statusCode}");
              response.value = "Internal Server Error. Please try again later.";
            }
          } else {
            Get.log("No response received");
            response.value = "Network error. Please check your connection.";
          }
        } else {
          Get.log("Non-DioException Error: $error");
        }
      }).whenComplete(
        () {
          loading.value = false;
        },
      );
    }
  }
}
