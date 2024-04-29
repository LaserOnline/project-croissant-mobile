import 'package:app_croissant/components/authenticator/view/generate-authenticator.dart';
import 'package:app_croissant/components/error/view/error.dart';
import 'package:app_croissant/components/login/view/login.dart';
import 'package:app_croissant/components/search/view/search.dart';
import 'package:app_croissant/module/widget/info-device/info-device.dart';
import 'package:get/get.dart';

import '../../components/about/view/about.dart';
import '../../components/app/view/app.dart';
import '../../components/authenticator/view/authenticator.dart';
import '../../components/friend/view/friend.dart';
import '../../components/otp/view/otp.dart';
import '../../components/pin/view/pin.dart';
import '../../components/privacy-security/view/privacy-security.dart';
import '../../components/splash/view/splash.dart';

class AppRouter {
  static final router = [
    GetPage(
      name: "/splash",
      page: () => const Splash(),
      popGesture: false,
    ),
    GetPage(
      name: "/search",
      page: () => const Search(),
      popGesture: false,
    ),
    GetPage(
      name: "/authenticator",
      page: () => const Authenticator(),
      popGesture: false,
    ),
    GetPage(
      name: "/otp",
      page: () => const OTP(),
      popGesture: false,
    ),
    GetPage(
      name: "/login",
      page: () => const Login(),
      popGesture: false,
    ),
    GetPage(
      name: "/pin",
      page: () => const Pin(),
    ),
    GetPage(
      name: "/error",
      page: () => const ErrorView(),
      popGesture: false,
    ),
    GetPage(
      name: "/app",
      page: () => const App(),
    ),
    GetPage(
      name: "/about",
      page: () => const About(),
    ),
    GetPage(
      name: "/info-devices",
      page: () => const InfoDevices(),
    ),
    GetPage(
      name: "/privacy-security",
      page: () => const PrivacySecurity(),
    ),
    GetPage(
      name: "/friend",
      page: () => const Friend(),
    ),
    GetPage(
      name: "/generate-auth",
      page: () => const GenerateAuthenticator(),
    ),
    GetPage(
      name: "/authenticator",
      page: () => const GenerateAuthenticator(),
    ),
  ];
}
