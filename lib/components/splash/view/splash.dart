import 'package:app_croissant/components/splash/controller/splash-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final splashController = Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.halfTriangleDot(
              color: Theme.of(context).colorScheme.scrim,
              size: Adaptive.h(20),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
