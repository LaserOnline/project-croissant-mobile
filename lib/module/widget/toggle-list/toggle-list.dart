import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ToggleListController extends GetxController {
  final List data = [
    'assets/icons/angle-down.png',
    'assets/icons/angle-up.png',
  ];
  final RxList devices = RxList(
    [
      "Devices 1",
      "Devices 1",
      "Devices 1",
      "Devices 1",
    ],
  );
  final Rx<bool> status = Rx(false);
  final Rx<String> showIcon = Rx('');
  final Rx<double> height = Rx(0);
  setStatus(bool value) {
    status.value = value;
  }

  setIcon(int value) {
    showIcon.value = data[value];
  }

  display(double h) {
    if (h > 900) {
      display900();
    } else if (h >= 800) {
      display800();
    } else if (h >= 700) {
      display700();
    } else {
      display600();
    }
  }

  display600() {
    if (devices.length == 1) {
      height.value = 10;
    } else if (devices.length == 2) {
      height.value = 19;
    } else if (devices.length == 3) {
      height.value = 29;
    } else if (devices.length == 4) {
      height.value = 39;
    }
  }

  display700() {
    if (devices.length == 1) {
      height.value = 8;
    } else if (devices.length == 2) {
      height.value = 16;
    } else if (devices.length == 3) {
      height.value = 24;
    } else if (devices.length == 4) {
      height.value = 31;
    }
  }

  display800() {
    if (devices.length == 1) {
      height.value = 7;
    } else if (devices.length == 2) {
      height.value = 14;
    } else if (devices.length == 3) {
      height.value = 22;
    } else if (devices.length == 4) {
      height.value = 29;
    }
  }

  display900() {
    if (devices.length == 1) {
      height.value = 6;
    } else if (devices.length == 2) {
      height.value = 13;
    } else if (devices.length == 3) {
      height.value = 20;
    } else if (devices.length == 4) {
      height.value = 26;
    }
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

  @override
  void onInit() {
    super.onInit();
    setIcon(0);
  }

  @override
  void onClose() {
    super.onClose();
    status.close();
    devices.close();
    showIcon.close();
    height.close();
    data.clear();
  }
}

class ToggleListDevice extends StatefulWidget {
  const ToggleListDevice({super.key});

  @override
  State<ToggleListDevice> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ToggleListDevice> {
  final toggleListController = Get.put(ToggleListController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;

    toggleListController.display(screenHeight);
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Device ${toggleListController.devices.length}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.scrim,
              ),
            ),
            tileColor: Theme.of(context).colorScheme.primary,
            onTap: () => toggleListController.event(),
            leading: Image.asset(
              'assets/icons/data-transfer.png',
              color: Theme.of(context).colorScheme.scrim,
              width: Adaptive.w(6),
            ),
            trailing: Obx(
              () => Image.asset(
                toggleListController.showIcon.value,
                color: Theme.of(context).colorScheme.scrim,
                width: Adaptive.w(6),
              ),
            ),
          ),
          Obx(() {
            if (toggleListController.status.value) {
              return SizedBox(
                height: Adaptive.h(toggleListController.height.value),
                width: Adaptive.w(95),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: toggleListController.devices.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      child: ListTile(
                        title: Text(
                          "${toggleListController.devices[index]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.scrim,
                          ),
                        ),
                        tileColor: Theme.of(context).colorScheme.primary,
                        onTap: () => Get.toNamed(
                          '/info-devices',
                          arguments: toggleListController.devices.toList(),
                        ),
                        leading: Image.asset(
                          'assets/icons/data-transfer.png',
                          color: Theme.of(context).colorScheme.scrim,
                          width: Adaptive.w(6),
                        ),
                        trailing: Image.asset(
                          'assets/icons/angle-right.png',
                          color: Theme.of(context).colorScheme.scrim,
                          width: Adaptive.w(6),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          })
        ],
      ),
    );
  }
}
