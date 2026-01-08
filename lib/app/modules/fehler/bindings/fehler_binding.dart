import 'package:get/get.dart';

import '../controllers/fehler_controller.dart';

class FehlerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FehlerController>(
      () => FehlerController(),
    );
  }
}
