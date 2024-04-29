import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/storage/storage.dart';

class ToggleListPinController extends GetxController {
  final storageService = Get.put(StorageService());

  Rx<bool> status = Rx(false);
  Rx<bool> statusLock = Rx(false);
  Rx<bool> statusSwitch = Rx(false);
  Rx<bool> statusFaceID = Rx(false);
  Rx<bool> enableMode = Rx(false);
  Rx<String> message = Rx('');
  Rx<String> imageIcon = Rx('');
  Rx<String> iconLock = Rx('');
  Rx<double> height = Rx(14);
  final List data = [
    'assets/icons/angle-down.png',
    'assets/icons/angle-up.png',
    'assets/icons/lock-open-alt.png',
    'assets/icons/padlock-check.png',
  ];
  @override
  void onInit() {
    super.onInit();
    status.value = storageService.getEnablePin();
    enableMode.value = storageService.getEnablePin();
    statusSwitch.value = storageService.getEnablePin();
    if (status.value) {
      setIconLock(3);
      message.value = "Enable";
    } else {
      setIconLock(2);
      message.value = "Disable";
    }
    setIcon(1);
  }

  @override
  void onClose() {
    super.onClose();
    imageIcon.close();
    iconLock.close();
    height.close();
    statusFaceID.close();
    statusSwitch.close();
    status.close();
    message.close();
    enableMode.close();
    storageService.dispose();
  }

  setStatus(bool value) {
    status.value = value;
  }

  setIcon(int value) {
    imageIcon.value = data[value];
  }

  setIconLock(int value) {
    iconLock.value = data[value];
  }

  setStatusLock(bool value) {
    statusLock.value = value;

    if (statusLock.value) {
      iconLock.value = data[3];
    } else {
      iconLock.value = data[2];
    }
  }

  setStatusSwitch(bool value) {
    statusSwitch.value = value;
    if (statusSwitch.value) {
      message.value = "Enable";
      storageService.enablePin();
      setIconLock(3);
    } else {
      storageService.disablePin();
      setIconLock(2);
      message.value = "Disable";
    }
  }

  setStatusFaceID(bool value) {
    statusFaceID.value = value;
    Get.log("setStatusFaceID");
  }

  event() {
    if (status.value) {
      setStatus(false);
      setIcon(0);
    } else {
      setStatus(true);
      setIcon(1);
    }
  }
}

class ToggleListPin extends StatelessWidget {
  ToggleListPin({super.key});
  final toggleController = Get.put(ToggleListPinController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "Lock App",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.scrim,
            ),
          ),
          tileColor: Theme.of(context).colorScheme.primary,
          onTap: () => toggleController.event(),
          leading: Obx(
            () => Image.asset(
              toggleController.iconLock.value,
              color: Theme.of(context).colorScheme.scrim,
              width: Adaptive.w(6),
            ),
          ),
          trailing: Obx(
            () => Image.asset(
              toggleController.imageIcon.value,
              color: Theme.of(context).colorScheme.scrim,
              width: Adaptive.w(6),
            ),
          ),
        ),
        Obx(() {
          if (toggleController.status.value) {
            return Padding(
              padding: const EdgeInsets.only(top: 3),
              child: SizedBox(
                width: Adaptive.w(95),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Set Pin",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.scrim,
                        ),
                      ),
                      tileColor: Theme.of(context).colorScheme.primary,
                      onTap: () => Get.toNamed(
                        '/pin',
                        arguments: true,
                      ),
                      leading: Image.asset(
                        'assets/icons/lock.png',
                        color: Theme.of(context).colorScheme.scrim,
                        width: Adaptive.w(6),
                      ),
                      trailing: Image.asset(
                        'assets/icons/angle-right.png',
                        color: Theme.of(context).colorScheme.scrim,
                        width: Adaptive.w(6),
                      ),
                    ),
                    Obx(() {
                      if (toggleController.enableMode.value) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: ListTile(
                            title: Text(
                              "${toggleController.message.value} Pin",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.scrim,
                              ),
                            ),
                            tileColor: Theme.of(context).colorScheme.primary,
                            onTap: () => Get.log("Enable Pin"),
                            leading: Image.asset(
                              toggleController.iconLock.value,
                              color: Theme.of(context).colorScheme.scrim,
                              width: Adaptive.w(6),
                            ),
                            trailing: Switch(
                              value: toggleController.statusSwitch.value,
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              activeTrackColor:
                                  Theme.of(context).colorScheme.scrim,
                              inactiveThumbColor:
                                  Theme.of(context).colorScheme.primary,
                              inactiveTrackColor:
                                  Theme.of(context).colorScheme.onBackground,
                              onChanged: (newValue) {
                                toggleController.setStatusSwitch(newValue);
                              },
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: ListTile(
                        title: Text(
                          "Face ID",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.scrim,
                          ),
                        ),
                        tileColor: Theme.of(context).colorScheme.primary,
                        onTap: () => Get.toNamed('/pin'),
                        leading: Image.asset(
                          'assets/icons/face-viewfinder.png',
                          color: Theme.of(context).colorScheme.scrim,
                          width: Adaptive.w(6),
                        ),
                        trailing: Switch(
                          value: toggleController.statusFaceID.value,
                          activeColor: Theme.of(context).colorScheme.primary,
                          activeTrackColor: Theme.of(context).colorScheme.scrim,
                          inactiveThumbColor:
                              Theme.of(context).colorScheme.primary,
                          inactiveTrackColor:
                              Theme.of(context).colorScheme.onBackground,
                          onChanged: (newValue) {
                            toggleController.setStatusFaceID(newValue);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        })
      ],
    );
  }
}
