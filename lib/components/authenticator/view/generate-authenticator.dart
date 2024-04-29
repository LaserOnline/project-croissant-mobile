import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../module/widget/appbar/appbar.dart';
import '../controller/authenticator-controller.dart';

class GenerateAuthenticator extends StatelessWidget {
  const GenerateAuthenticator({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatorController = Get.put(AuthenticatorController());
    return Scaffold(
      appBar: appbarStyleSettingMenu(
        "Authenticator",
        Theme.of(context).colorScheme.scrim,
        Theme.of(context).colorScheme.background,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Adaptive.h(9),
              width: Adaptive.w(95),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/key.png',
                      scale: Adaptive.w(2.5),
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontSize: Adaptive.h(5),
                      fontWeight: FontWeight.bold,
                    ),
                    child: Obx(
                      () => AnimatedTextKit(
                        key: ValueKey<int>(
                            authenticatorController.keyNumber.value),
                        animatedTexts: [
                          TyperAnimatedText(
                            authenticatorController.keyNumber.toString(),
                            speed: const Duration(milliseconds: 200),
                          ),
                        ],
                        totalRepeatCount: 1,
                      ),
                    ),
                  ),
                  Obx(
                    () => Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: authenticatorController.second.value / 30.0,
                          strokeWidth: 8,
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
                          color: Theme.of(context).colorScheme.scrim,
                        ),
                        Text(
                          "${authenticatorController.second.value}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.scrim,
                            fontSize: Adaptive.h(1.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
