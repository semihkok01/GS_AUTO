import 'package:get/get.dart';

class ProductsController extends GetxController {
  List table1 = [].obs;
  List table2 = [].obs;
  List table3 = [].obs;
  List table4 = [].obs;
  List table5 = [].obs;
  List table6 = [].obs;
  List table7 = [].obs;

  tableSum() {
    var tablesum = 0.0.obs;
    return tablesum;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
