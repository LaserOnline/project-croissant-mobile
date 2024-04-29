import 'package:app_croissant/components/friend/controller/friend-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../module/widget/appbar/appbar.dart';

class Friend extends StatelessWidget {
  const Friend({super.key});

  @override
  Widget build(BuildContext context) {
    final friendController = Get.put(FriendController());
    return Scaffold(
      appBar: appbarStyleSettingMenu(
        "Friend",
        Theme.of(context).colorScheme.scrim,
        Theme.of(context).colorScheme.background,
      ),
    );
  }
}
