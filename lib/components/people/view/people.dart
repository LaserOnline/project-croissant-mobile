import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/people-controller.dart';

class People extends StatelessWidget {
  const People({super.key});

  @override
  Widget build(BuildContext context) {
    final peopleController = Get.put(PeopleController());
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topCenter,
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
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
