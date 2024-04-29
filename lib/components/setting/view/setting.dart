import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:lottie/lottie.dart';
import '../../../module/widget/change-background/change-background.dart';
import '../../../module/widget/profile/profile.dart';
import '../controller/setting-controller.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Get.put(SettingController());
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.bottomRight,
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                "App Setting",
                textStyle: TextStyle(
                  fontSize: Adaptive.w(9),
                  color: Theme.of(context).colorScheme.scrim,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 200),
              ),
            ],
            totalRepeatCount: 1,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: Adaptive.h(25),
                    width: Adaptive.w(100),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Obx(
                      () => SizedBox(
                        child: Lottie.asset(
                          settingController.selectBackground.toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ProfileBase64(
                        base64Image: settingController.profile.value,
                        event: () => Get.log("upload image"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Adaptive.h(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: Adaptive.w(70),
                          child: AutoSizeText(
                            settingController.email.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: 20,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.scrim,
                              fontSize: Adaptive.w(5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: Adaptive.w(50),
                          child: Center(
                            child: AutoSizeText(
                              settingController.username.value,
                              maxLines: 1,
                              minFontSize: 20,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.scrim,
                                fontSize: Adaptive.w(3),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: ListTile(
                  title: Text(
                    "Change Background",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  tileColor: Theme.of(context).colorScheme.primary,
                  onTap: () => Get.to(() => const ChangeBackground()),
                  leading: Image.asset(
                    'assets/icons/mode-landscape.png',
                    color: Theme.of(context).colorScheme.scrim,
                    width: Adaptive.w(6),
                  ),
                  trailing: Image.asset(
                    'assets/icons/angle-right.png',
                    color: Theme.of(context).colorScheme.scrim,
                    width: Adaptive.w(6),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: ListTile(
                  title: Text(
                    "Privacy & Security",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  tileColor: Theme.of(context).colorScheme.primary,
                  onTap: () => Get.toNamed('/privacy-security'),
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: ListTile(
                  title: Text(
                    "Authenticator",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  tileColor: Theme.of(context).colorScheme.primary,
                  onTap: () => Get.toNamed('/generate-auth'),
                  leading: Image.asset(
                    'assets/icons/key.png',
                    color: Theme.of(context).colorScheme.scrim,
                    width: Adaptive.w(6),
                  ),
                  trailing: Image.asset(
                    'assets/icons/angle-right.png',
                    color: Theme.of(context).colorScheme.scrim,
                    width: Adaptive.w(6),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: ListTile(
                  title: Text(
                    "Add Friend",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  tileColor: Theme.of(context).colorScheme.primary,
                  onTap: () => Get.toNamed('/friend'),
                  leading: Image.asset(
                    'assets/icons/user-add.png',
                    color: Theme.of(context).colorScheme.scrim,
                    width: Adaptive.w(6),
                  ),
                  trailing: Image.asset(
                    'assets/icons/angle-right.png',
                    color: Theme.of(context).colorScheme.scrim,
                    width: Adaptive.w(6),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: ListTile(
                  title: Text(
                    "About",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  tileColor: Theme.of(context).colorScheme.primary,
                  onTap: () => Get.toNamed('/about'),
                  leading: Image.asset(
                    'assets/icons/bulb.png',
                    color: Theme.of(context).colorScheme.scrim,
                    width: Adaptive.w(6),
                  ),
                  trailing: Image.asset(
                    'assets/icons/angle-right.png',
                    color: Theme.of(context).colorScheme.scrim,
                    width: Adaptive.w(6),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  tileColor: Theme.of(context).colorScheme.primary,
                  onTap: () => settingController
                      .logout(Theme.of(context).colorScheme.scrim),
                  leading: Image.asset(
                    'assets/icons/sign-out-alt.png',
                    color: Theme.of(context).colorScheme.scrim,
                    width: Adaptive.w(6),
                  ),
                  trailing: Image.asset(
                    'assets/icons/angle-right.png',
                    color: Theme.of(context).colorScheme.scrim,
                    width: Adaptive.w(6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
