import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_order_basic/app/modules/products/models/product_model.dart';

var save = GetStorage();

class CategoriesController extends GetxController {
  var categori = TextEditingController();
  var name = TextEditingController();
  var price = TextEditingController();
  var catvalue;

  saveProduct(String? categorie, String? name, double? price) {
    //this will be safe the Product with the next Product number, for all new Products it will get the Auto next Number,

    List<ProductModel> product = [];
    var prnumber;
    save.read("prnumber");
    prnumber++;
    save.write(prnumber, product);
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
