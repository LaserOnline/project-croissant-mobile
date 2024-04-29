import 'package:flutter/material.dart';
import 'package:get/get.dart';

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) => AlertDialog(
      content: ListTile(
        title: Text(title ?? ""),
        subtitle: Text(body ?? ""),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Ok'),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            if (payload != null) {
              Get.toNamed(payload);
            }
          },
        ),
      ],
    ),
  );
}
