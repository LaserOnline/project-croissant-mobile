import 'package:app_croissant/components/register/view/register.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../module/widget/flexible-spaceBar/flexible-spaceBar.dart';
import '../controller/login-controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Login> {
  final loginController = Get.put(LoginController());
  late ValueNotifier<bool> isUsernameNotEmpty;
  bool hinPassword = true;
  @override
  void initState() {
    loginController.onInit();
    super.initState();
  }

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  TabBar get _tabBar => const TabBar(
        tabs: [],
      );

  @override
  Widget build(BuildContext context) {
    List<String> tabs = <String>['Login', 'Register'];
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double totalSize = mediaQuery.size.width + mediaQuery.size.height;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: Text(
                    "Welcome",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  pinned: true,
                  centerTitle: true,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  elevation: 0,
                  expandedHeight: Adaptive.h(35),
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: _tabBar.preferredSize,
                    child: ColoredBox(
                      color: Theme.of(context).colorScheme.scrim,
                      child: TabBar(
                        tabs:
                            tabs.map((String name) => Tab(text: name)).toList(),
                        labelStyle: TextStyle(
                          fontSize: ((totalSize / 100) * 01.3),
                          fontWeight: FontWeight.bold,
                        ),
                        indicatorWeight: 1,
                        unselectedLabelStyle: TextStyle(
                          fontSize: ((totalSize / 100) * 01.1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  flexibleSpace: const FlexibleSpaceBar(
                    background: FlexibleSpaceBarWidget(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Adaptive.h(30),
                      ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                            controller:
                                loginController.usernameController.value,
                            textAlign: TextAlign.justify,
                            cursorColor: Colors.red,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              suffixIcon:
                                  loginController.isUsernameNotEmpty.value
                                      ? GestureDetector(
                                          onTap: () {
                                            loginController.clearController();
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.cancel,
                                                color: Colors.grey),
                                          ),
                                        )
                                      : const SizedBox(),
                            ),
                          ),
                        ),
                      ),
                      Obx(() {
                        if (loginController.logErrUsername.value.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              loginController.logErrUsername.toString(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: Adaptive.h(1),
                          );
                        }
                      }),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                            controller:
                                loginController.passwordController.value,
                            obscureText: loginController.enablePassword.value,
                            textAlign: TextAlign.justify,
                            cursorColor: Colors.red,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              suffixIcon: loginController
                                      .isPasswordNotEmpty.value
                                  ? GestureDetector(
                                      onTap: () =>
                                          loginController.hinPassword(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          loginController.enablePassword.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      Obx(() {
                        if (loginController.logErrPassword.value.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              loginController.logErrPassword.toString(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: Adaptive.h(1),
                          );
                        }
                      }),
                      GestureDetector(
                        onTap: () => loginController.submit(
                          loginController.usernameController.value.text,
                          loginController.passwordController.value.text,
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
                                "Sing ln",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(() {
                        if (loginController.responseError.value != "") {
                          return SizedBox(
                            width: Adaptive.w(90),
                            child: Column(
                              children: [
                                AutoSizeText(
                                  loginController.responseError.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: Adaptive.h(20),
                          );
                        }
                      })
                    ],
                  ),
                ),
              ),
              const Register(),
            ],
          ),
        ),
      ),
    );
  }
}
