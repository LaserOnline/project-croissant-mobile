import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/privacy-security-controller.dart';
import '../../../module/widget/toggle-list/toggle-list.dart';
import '../../../module/widget/toggle-list/toggle-privacy-security.dart';
import '../../../module/widget/appbar/appbar.dart';

class PrivacySecurity extends StatelessWidget {
  const PrivacySecurity({super.key});

  @override
  Widget build(BuildContext context) {
    final privacySecurityController = Get.put(PrivacySecurityController());

    return Scaffold(
      appBar: appbarStyleSettingMenu(
        "Privacy Security",
        Theme.of(context).colorScheme.scrim,
        Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ToggleListDevice(),
            ToggleListPin(),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: ListTile(
                title: Text(
                  "Notification",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.scrim,
                  ),
                ),
                tileColor: Theme.of(context).colorScheme.primary,
                leading: Image.asset(
                  'assets/icons/bell.png',
                  color: Theme.of(context).colorScheme.scrim,
                  width: Adaptive.w(6),
                ),
                trailing: Obx(
                  () => Switch(
                    value: privacySecurityController.statusNotification.value,
                    activeColor: Theme.of(context).colorScheme.primary,
                    activeTrackColor: Theme.of(context).colorScheme.scrim,
                    inactiveThumbColor: Theme.of(context).colorScheme.primary,
                    inactiveTrackColor:
                        Theme.of(context).colorScheme.onBackground,
                    onChanged: (newValue) {
                      privacySecurityController.requestNotification(newValue);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
