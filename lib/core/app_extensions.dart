import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension NumberExtension on num {
  double get h {
    return MediaQuery.of(Get.context!).size.height * (this / 100);
  }

  double get w {
    return MediaQuery.of(Get.context!).size.width * (this / 100);
  }
}
