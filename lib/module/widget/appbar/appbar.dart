import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

appbarStyleSettingMenu(String title, Color colorText, Color background) =>
    AppBar(
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "${title}",
          style: TextStyle(
            color: colorText,
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
          color: colorText,
        ),
      ),
      elevation: 0,
      backgroundColor: background,
    );
