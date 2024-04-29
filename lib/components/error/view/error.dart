import 'package:app_croissant/components/error/controller/error-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final errorController = Get.put(ErrorController());
    return Scaffold();
  }
}
