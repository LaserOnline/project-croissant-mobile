import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/otp-controller.dart';

class OTP extends StatelessWidget {
  const OTP({super.key});
  @override
  Widget build(BuildContext context) {
    final otpController = Get.put(OTPController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Adaptive.h(25),
              width: Adaptive.w(100),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        "Enter OTP",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.scrim,
                          fontSize: Adaptive.w(7),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        otpController.logError.value,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.scrim,
                          fontSize: Adaptive.h(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Adaptive.h(10),
            ),
            Obx(
              () => Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      value: otpController.seconds.value / 60.0,
                      strokeWidth: 8,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  Text(
                    otpController.seconds.value.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.scrim,
                      fontSize: Adaptive.h(3),
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Adaptive.h(10),
            ),
            SizedBox(
              width: Adaptive.w(80),
              child: Obx(() {
                if (otpController.loading.value) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Theme.of(context).colorScheme.primary,
                      size: 50,
                    ),
                  );
                } else {
                  return Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          height: 68,
                          width: 64,
                          child: TextField(
                            controller:
                                otpController.otpFieldControllers[index],
                            readOnly: otpController.enableField[index],
                            onChanged: (value) async {
                              if (value.length == 1) {
                                if (otpController.data.length < 3) {
                                  FocusScope.of(context).nextFocus();
                                }
                                otpController.addData(int.parse(value), index);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "0",
                              hintStyle: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.normal,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.scrim,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: otpController.enableField[index]
                                      ? Theme.of(context).colorScheme.scrim
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: otpController.enableField[index]
                                      ? Theme.of(context).colorScheme.scrim
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.scrim,
                              fontWeight: FontWeight.normal,
                              fontSize: 35,
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: Theme.of(context).colorScheme.primary,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        );
                      }),
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
