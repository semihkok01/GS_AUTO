
// ignore: implementation_imports

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class CancelController extends GetxController {
  var depo = GetStorage();
  TextEditingController betrag = TextEditingController();
  TextEditingController notiz = TextEditingController();

  storno(double tutar, String note) async {
    await depo.writeIfNull("zstorno", 0.00);
    await depo.writeIfNull("ztutar", 0.00);
    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy HH:mm');
    final String timestamp = formatter.format(now);
    double znow = double.parse(depo.read("zstorno").toString());

    double zson = znow + tutar;

    await depo.write("zstorno", zson);
    await depo.writeIfNull("zAciklama", "");
    await depo.write("ztutar", tutar);

    String notizler = depo.read("zAciklama").toString();
    String notizekle = timestamp +
        "- " +
        notizler +
        "/" +
        note +
        " - Tutar: " +
        tutar.toString() +
        " ";

    await depo.write("zAciklama", notizekle);

    Get.back();
    betrag.clear();
    notiz.clear();
    Get.snackbar("Storno Bestätigt",
        "Betrag: ${tutar.toString()}" + " Notiz: ${note.toString()}");
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