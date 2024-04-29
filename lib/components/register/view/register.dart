import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/register-controller.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: Adaptive.h(25),
          ),
          SizedBox(
            width: Adaptive.w(80),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "Enter Username",
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontSize: Adaptive.w(4),
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                totalRepeatCount: 1,
              ),
            ),
          ),
          SizedBox(
            width: Adaptive.w(80),
            child: TextField(
              controller: registerController.usernameController.value,
              textAlign: TextAlign.justify,
              cursorColor: Colors.red,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: "Username",
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          Obx(() {
            if (registerController.logErrUsername != "") {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  registerController.logErrUsername.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
          SizedBox(
            width: Adaptive.w(80),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "Enter Email",
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontSize: Adaptive.w(4),
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                totalRepeatCount: 1,
              ),
            ),
          ),
          SizedBox(
            width: Adaptive.w(80),
            child: TextField(
              controller: registerController.emailController.value,
              textAlign: TextAlign.justify,
              cursorColor: Colors.red,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          Obx(() {
            if (registerController.logErrEmail != "") {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  registerController.logErrEmail.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
          SizedBox(
            width: Adaptive.w(80),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "Enter Password",
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontSize: Adaptive.w(4),
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                totalRepeatCount: 1,
              ),
            ),
          ),
          SizedBox(
            width: Adaptive.w(80),
            child: TextField(
              controller: registerController.passwordController.value,
              textAlign: TextAlign.justify,
              cursorColor: Colors.red,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          Obx(() {
            if (registerController.logErrPassword != "") {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  registerController.logErrPassword.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
          SizedBox(
            width: Adaptive.w(80),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "Enter Password Verification",
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontSize: Adaptive.w(4),
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                totalRepeatCount: 1,
              ),
            ),
          ),
          SizedBox(
            width: Adaptive.w(80),
            child: TextField(
              controller:
                  registerController.passwordVerificationController.value,
              textAlign: TextAlign.justify,
              cursorColor: Colors.red,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: "Password Verification",
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),
          Obx(() {
            if (registerController.logErrPasswordVerification != "") {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  registerController.logErrPasswordVerification.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
          Obx(() {
            if (registerController.loading.value) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: Adaptive.h(7.5),
                    width: Adaptive.w(80),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: LoadingAnimationWidget.twoRotatingArc(
                        color: Theme.of(context).colorScheme.scrim,
                        size: Adaptive.h(4),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () => registerController.submit(
                    registerController.usernameController.value.text,
                    registerController.emailController.value.text,
                    registerController.passwordController.value.text,
                    registerController
                        .passwordVerificationController.value.text,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: Adaptive.h(7.5),
                      width: Adaptive.w(80),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Sing Up",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
          Obx(() {
            if (registerController.response != "") {
              return SizedBox(
                width: Adaptive.w(80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      registerController.response.value,
                      maxLines: 3,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          })
        ],
      ),
    );
  }
}
