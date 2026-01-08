import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  var save = GetStorage();

  var dukkanismi = TextEditingController(text: GetStorage().read("dukkan"));
  var inhaber = TextEditingController(text: GetStorage().read("inhaber"));
  var adress = TextEditingController(text: GetStorage().read("adresse"));
  var plz = TextEditingController(text: GetStorage().read("plz"));
  var telefon = TextEditingController(text: GetStorage().read("telefon"));
  var steuer = TextEditingController(text: GetStorage().read("steuer"));
  var btprinter = TextEditingController(text: GetStorage().read("btprinter"));
  var ipprinter0 = TextEditingController(text: GetStorage().read("ipprinter0"));
  var ipprinter1 = TextEditingController(text: GetStorage().read("ipprinter1"));
  var ipprinter2 = TextEditingController(text: GetStorage().read("ipprinter2"));
  var ipprinter3 = TextEditingController(text: GetStorage().read("ipprinter3"));
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
