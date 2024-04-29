import 'package:app_croissant/components/about/controller/about-controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../module/widget/appbar/appbar.dart';
import '../../../module/widget/profile/profile.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final aboutController = Get.put(AboutController());
    return Scaffold(
      appBar: appbarStyleSettingMenu(
        "About",
        Theme.of(context).colorScheme.scrim,
        Theme.of(context).colorScheme.background,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProfileAssets(
              pathImage: '436255056_409660795016654_5207319558475547520_n.jpg',
            ),
            SizedBox(
              width: Adaptive.w(80),
              child: Center(
                child: AutoSizeText(
                  "Develop By LaserOnline",
                  maxLines: 1,
                  minFontSize: 12,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.scrim,
                    fontSize: Adaptive.h(4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Adaptive.w(80),
              child: Center(
                child: AutoSizeText(
                  "FullStack Developer",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.scrim,
                    fontSize: Adaptive.h(2.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Adaptive.w(40),
              child: Center(
                child: AutoSizeText(
                  "Link Github",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.scrim,
                    fontSize: Adaptive.h(2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => aboutController.openWeb(),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: Adaptive.h(6),
                  width: Adaptive.w(50),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Link GitHub",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.scrim,
                        fontSize: Adaptive.h(3),
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
    );
  }
}
