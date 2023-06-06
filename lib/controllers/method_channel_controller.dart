import 'package:flutter/services.dart';

class MethodChannelController {
  static const MethodChannel ussdChannel =
      MethodChannel("ativaja.co.mz/ussd_channel");

  Future<bool> isServiceEnabled() async {
    final bool result = await ussdChannel.invokeMethod("isServiceEnabled");
    return result;
  }

  void enableService() {
    ussdChannel.invokeMethod("enableService");
  }

  void executeUSSD(String ussdCode, String steps) {
    ussdChannel.invokeMethod(
      "executeUSSD",
      {"ussdCode": ussdCode, "steps": steps},
    );
  }
}
