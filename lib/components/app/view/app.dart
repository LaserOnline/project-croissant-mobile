import 'package:app_croissant/components/error/view/error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/app-controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const Mobile();
        } else if (constraints.maxWidth < 1200) {
          return const ErrorView();
        } else {
          return const ErrorView();
        }
      },
    );
  }
}

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  final appController = Get.put(AppController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: Adaptive.h(9),
          elevation: 0,
          selectedIndex: appController.selectedIndex.value,
          onDestinationSelected: (index) =>
              appController.selectedIndex.value = index,
          backgroundColor: Theme.of(context).colorScheme.primary,
          destinations: [
            NavigationDestination(
              icon: Image.asset(
                'assets/icons/home.png',
                width: Adaptive.h(2.9),
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/icons/users-alt.png',
                width: Adaptive.h(2.9),
              ),
              label: "People",
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/icons/comment.png',
                width: Adaptive.h(2.9),
              ),
              label: "Message",
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/icons/settings.png',
                width: Adaptive.h(2.9),
              ),
              label: "Setting",
            ),
          ],
        ),
      ),
      body: Obx(
        () => appController.screens[appController.selectedIndex.value],
      ),
    );
  }
}
