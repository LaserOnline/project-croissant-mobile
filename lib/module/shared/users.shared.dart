import 'package:get/get.dart';
import '../model/users.model.dart';

class UsersShared extends GetxController {
  final userInfo = Rxn<UserInfo>();

  void setUserInfo(UserInfo info) {
    userInfo.value = info;
  }

  UserInfo? get getUserInfo => userInfo.value;
}
