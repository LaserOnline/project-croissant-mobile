import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../module/api/api-service.dart';
import '../../../module/core/secure-storage/secure-storage.dart';
import '../../../module/model/users.model.dart';
import '../../../module/shared/users.shared.dart';

class SettingController extends GetxController {
  final secureStorage = SecureStorage();
  final apiServer = Get.find<ApiServer>();
  final userController = Get.find<UsersShared>();
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final Rx<String> selectBackground = Rx('');
  final Rx<String> email = Rx('');
  final Rx<String> username = Rx('');
  final Rx<String> profile = Rx('');
  final RxList<String> wallpaper = RxList([
    'assets/wallpaper/AnimationBackground1.json',
    'assets/wallpaper/AnimationBackground2.json',
    'assets/wallpaper/AnimationBackground3.json',
    'assets/wallpaper/AnimationBackground4.json',
    'assets/wallpaper/AnimationBackground5.json',
    'assets/wallpaper/AnimationBackground6.json',
    'assets/wallpaper/AnimationBackground7.json',
  ]);
  void loadData() async {
    UserInfo? user = userController.getUserInfo;
    if (user != null) {
      email.value = user.email;
      username.value = user.username;
      profile.value = user.profile;
    }
    selectBackground.value = wallpaper[0];
  }

  void setBackground(int value) {
    selectBackground.value = wallpaper[value];
  }

  void logout(Color color) async {
    // Get.offAllNamed('/login');
    Get.dialog(
      AlertDialog(
        title: Center(
            child: Text(
          "Logout",
          style: TextStyle(color: color),
        )),
        content: Text(
          "คุณแน่ใจหรือไม่ ที่จะออกจากระบบ",
          style: TextStyle(color: color),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "Close",
                  style: TextStyle(color: color),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await apiServer.logoutDevice();
                  Get.offAllNamed('/login');
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: color),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
