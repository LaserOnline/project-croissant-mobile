import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_croissant/components/message/controller/message-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    final messageController = Get.put(MessageController());
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topCenter,
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                "Message",
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
      body: Center(
        child: TextButton(
          child: Text("Test"),
          onPressed: () {
            Get.log("Test");
            messageController.showNotification();
          },
        ),
      ),
    );
  }
}
