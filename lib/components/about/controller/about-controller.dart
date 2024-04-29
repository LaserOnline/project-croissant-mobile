import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void openWeb() async {
    final Uri url = Uri.parse("https://github.com/LaserOnline");
    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}
