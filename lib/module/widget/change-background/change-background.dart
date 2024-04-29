import 'package:app_croissant/components/setting/controller/setting-controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangeBackground extends StatefulWidget {
  const ChangeBackground({super.key});

  @override
  State<ChangeBackground> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ChangeBackground> {
  final settingController = Get.put(SettingController());
  int sized = 0;
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
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Background",
            style: TextStyle(
              color: Theme.of(context).colorScheme.scrim,
              fontWeight: FontWeight.bold,
              fontSize: Adaptive.w(9),
            ),
          ),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Image.asset(
            'assets/icons/angle-left.png',
            cacheWidth: Adaptive.w(6).toInt(),
            color: Theme.of(context).colorScheme.scrim,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: Adaptive.w(40),
              child: Center(
                child: Text(
                  "Active Background",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.scrim,
                    fontSize: Adaptive.w(4),
                  ),
                ),
              ),
            ),
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
            SizedBox(
              width: Adaptive.w(40),
              child: Center(
                child: Text(
                  "Change Background",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.scrim,
                    fontSize: Adaptive.w(4),
                  ),
                ),
              ),
            ),
            GetBuilder<SettingController>(
              init: SettingController(),
              builder: (controller) {
                return Column(
                  children: List.generate(
                    controller.wallpaper.length,
                    (index) {
                      int id = 1;
                      id += index;
                      return Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: AutoSizeText(
                                    "Background ${id}",
                                    maxLines: 1,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.scrim,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Adaptive.w(3.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  settingController.setBackground(index),
                              child: Container(
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
                                child: SizedBox(
                                  child: Lottie.asset(
                                    settingController.wallpaper[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
