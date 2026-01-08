import 'package:get/get.dart';

import '../controllers/cancel_controller.dart';

class CancelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CancelController>(
      () => CancelController(),
    );
  }
}
