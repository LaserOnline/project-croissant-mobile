import 'package:app_croissant/components/message/view/message.dart';
import 'package:app_croissant/components/people/view/people.dart';
import 'package:app_croissant/components/setting/view/setting.dart';
import 'package:get/get.dart';

import '../../home/view/home.dart';

class AppController extends GetxController {
  final Rx<int> selectedIndex = Rx(0);
  List screens = [
    const Home(),
    const People(),
    const Message(),
    const Setting(),
  ];

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
