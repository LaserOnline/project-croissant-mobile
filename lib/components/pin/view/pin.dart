import 'package:app_croissant/components/pin/controller/pin-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../module/widget/button/button.dart';

class Pin extends StatefulWidget {
  const Pin({super.key});

  @override
  State<Pin> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Pin> {
  final pinController = Get.put(PinController());

  bool setPinMode = Get.arguments ?? false;
  @override
  void initState() {
    super.initState();
    pinController.setup(setPinMode);
  }

  @override
  void dispose() {
    super.dispose();
    pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: Adaptive.h(20),
                width: Adaptive.w(100),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: setPinMode
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: Image.asset(
                              'assets/icons/angle-left.png',
                              cacheWidth: Adaptive.w(9).toInt(),
                              color: Theme.of(context).colorScheme.scrim,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: Adaptive.w(20),
                            ),
                            child: SizedBox(
                              width: Adaptive.h(30),
                              child: Center(
                                child: Text(
                                  "Pin",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.scrim,
                                    fontSize: Adaptive.h(4),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: Image.asset(
                                pinController.imageApp.value,
                                color: Theme.of(context).colorScheme.scrim,
                                scale: Adaptive.h(2.5),
                              ),
                            ),
                          ),
                          Text(
                            "Lock",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.scrim,
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.h(5),
                            ),
                          ),
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<PinController>(
                  id: 'title',
                  builder: (controller) => Text(
                    controller.title.value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontWeight: FontWeight.bold,
                      fontSize: Adaptive.h(3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: Adaptive.w(50),
                  height: Adaptive.h(6),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return GetBuilder<PinController>(
                        id: 'pinNumber',
                        builder: (controller) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: Adaptive.w(8),
                            height: Adaptive.h(6),
                            decoration: BoxDecoration(
                              color: index < controller.countPin.value
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.scrim,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Adaptive.h(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonNumber(
                    number: "1",
                    event: () => pinController.setPin(1),
                    styleText: Theme.of(context).colorScheme.scrim,
                    styleBackground: Theme.of(context).colorScheme.primary,
                  ),
                  buttonNumber(
                    number: "2",
                    event: () => pinController.setPin(2),
                    styleText: Theme.of(context).colorScheme.scrim,
                    styleBackground: Theme.of(context).colorScheme.primary,
                  ),
                  buttonNumber(
                    number: "3",
                    event: () => pinController.setPin(3),
                    styleText: Theme.of(context).colorScheme.scrim,
                    styleBackground: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonNumber(
                    number: "4",
                    event: () => pinController.setPin(4),
                    styleText: Theme.of(context).colorScheme.scrim,
                    styleBackground: Theme.of(context).colorScheme.primary,
                  ),
                  buttonNumber(
                    number: "5",
                    event: () => pinController.setPin(5),
                    styleText: Theme.of(context).colorScheme.scrim,
                    styleBackground: Theme.of(context).colorScheme.primary,
                  ),
                  buttonNumber(
                    number: "6",
                    event: () => pinController.setPin(6),
                    styleText: Theme.of(context).colorScheme.scrim,
                    styleBackground: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonNumber(
                    number: "7",
                    event: () => pinController.setPin(7),
                    styleText: Theme.of(context).colorScheme.scrim,
                    styleBackground: Theme.of(context).colorScheme.primary,
                  ),
                  buttonNumber(
                    number: "8",
                    event: () => pinController.setPin(8),
                    styleText: Theme.of(context).colorScheme.scrim,
                    styleBackground: Theme.of(context).colorScheme.primary,
                  ),
                  buttonNumber(
                    number: "9",
                    event: () => pinController.setPin(9),
                    styleText: Theme.of(context).colorScheme.scrim,
                    styleBackground: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    if (pinController.supportFaceID.value) {
                      return setPinMode
                          ? Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                width: Adaptive.w(20),
                                height: Adaptive.h(7),
                              ),
                            )
                          : Obx(() {
                              if (pinController.pinNumber.length == 4) {
                                return Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: SizedBox(
                                    width: Adaptive.w(20),
                                    height: Adaptive.h(7),
                                  ),
                                );
                              } else {
                                return buttonIcon(
                                  icon: "face-viewfinder.png",
                                  event: () => pinController.authFaceID(),
                                  styleText:
                                      Theme.of(context).colorScheme.scrim,
                                  styleBackground:
                                      Theme.of(context).colorScheme.primary,
                                );
                              }
                            });
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: Adaptive.w(20),
                          height: Adaptive.h(7),
                        ),
                      );
                    }
                  }),
                  buttonNumber(
                    number: "0",
                    event: () => pinController.setPin(7),
                    styleText: Theme.of(context).colorScheme.scrim,
                    styleBackground: Theme.of(context).colorScheme.primary,
                  ),
                  Obx(() {
                    if (pinController.pinNumber.length == 4) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: Adaptive.w(20),
                          height: Adaptive.h(7),
                        ),
                      );
                    } else {
                      return buttonIcon(
                        icon: "delete.png",
                        event: () => pinController.popPin(),
                        styleText: Theme.of(context).colorScheme.scrim,
                        styleBackground: Theme.of(context).colorScheme.primary,
                      );
                    }
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
