import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget buttonNumber({
  required String number,
  required VoidCallback event,
  required Color styleText,
  required Color styleBackground,
}) {
  return GestureDetector(
    onTap: event,
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: Adaptive.w(20),
        height: Adaptive.h(7),
        decoration: BoxDecoration(
          color: styleBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: styleText,
          ),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              color: styleText,
              fontSize: Adaptive.h(3),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buttonIcon({
  required String icon,
  required VoidCallback event,
  required Color styleText,
  required Color styleBackground,
}) {
  return GestureDetector(
    onTap: event,
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: Adaptive.w(20),
        height: Adaptive.h(7),
        decoration: BoxDecoration(
          color: styleBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: styleText,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: Adaptive.w(10),
            child: Image.asset(
              'assets/icons/${icon}',
              fit: BoxFit.fill,
              color: styleText,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buttonEdit({
  required String icon,
  required VoidCallback event,
  required Color styleText,
  required Color styleBackground,
}) {
  return GestureDetector(
    onTap: event,
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: Adaptive.w(80),
        height: Adaptive.h(7),
        decoration: BoxDecoration(
          color: styleBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: styleText,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                "Reset Pin",
                style: TextStyle(
                  color: styleText,
                  fontSize: Adaptive.h(2.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: Adaptive.w(8),
                child: Image.asset(
                  'assets/icons/${icon}',
                  fit: BoxFit.fill,
                  color: styleText,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
