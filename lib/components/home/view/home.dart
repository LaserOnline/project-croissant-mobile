import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_croissant/components/home/controller/home-controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                "People",
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
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed('/search'),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/icons/search.png',
                color: Theme.of(context).colorScheme.scrim,
                scale: Adaptive.w(3.2),
              ),
            ),
          ),
          SizedBox(
            width: Adaptive.w(2),
          ),
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
