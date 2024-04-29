import 'package:flutter/material.dart';
import '../appbar/appbar.dart';

class InfoDevices extends StatelessWidget {
  const InfoDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarStyleSettingMenu(
        "Device",
        Theme.of(context).colorScheme.scrim,
        Theme.of(context).colorScheme.background,
      ),
    );
  }
}
