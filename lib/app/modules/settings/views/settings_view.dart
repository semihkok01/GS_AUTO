import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/settings_controller.dart';

var save = GetStorage();

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allgemein Ayarlar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  "Geschäft Informationen",
                  style: TextStyle(fontSize: 30),
                ),
                /* Text("Info:"),
                Text("Dukkan ismi: ${save.read("dukkan").toString()}"),
                Text("Inhaber: ${save.read("inhaber").toString()}"),
                Text("Adresse+Hausnummer: ${save.read("adresse").toString()}"),
                Text("PLZ,ORT: ${save.read("plz").toString()}"),
                Text("Telefon: ${save.read("telefon").toString()}"),
                Text("Steuer Nummer: ${save.read("steuer").toString()}"), */
                /* TextField(
                    controller: controller.dukkanismi,
                    decoration: InputDecoration(labelText: 'Dükkan Ismi')),
                TextField(
                    controller: controller.inhaber,
                    decoration: InputDecoration(labelText: 'Inhaber')),
                TextField(
                    controller: controller.adress,
                    decoration:
                        InputDecoration(labelText: 'Adresse + Hausnummer')),
                TextField(
                    controller: controller.plz,
                    decoration: InputDecoration(labelText: 'PLZ,ORT')),
                TextField(
                    controller: controller.telefon,
                    decoration: InputDecoration(labelText: 'Telefon:')),
                TextField(
                    controller: controller.steuer,
                    decoration: InputDecoration(labelText: 'Steuer Nummer')), */
                ElevatedButton(
                    onPressed: () {
                      save.write(
                          "dukkan", controller.dukkanismi.text.toString());
                      save.write("inhaber", controller.inhaber.text.toString());
                      save.write("adresse", controller.adress.text.toString());
                      save.write("plz", controller.plz.text.toString());
                      save.write("telefon", controller.telefon.text.toString());
                      save.write("steuer", controller.steuer.text.toString());
                      print(save.read("dukkan") +
                          ", " +
                          save.read("inhaber") +
                          ", " +
                          save.read("adresse") +
                          ", " +
                          save.read("plz") +
                          ", " +
                          save.read("telefon") +
                          ", " +
                          save.read("steuer"));
                      Get.back();
                    },
                    child: Text("Kayit")),
                Text(
                  'Yazici IP Numarasini verin ve kaydedin.',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                    controller: controller.btprinter,
                    decoration: InputDecoration(
                        labelText: 'Bluetooth Printer Mac Adress')),
                SizedBox(
                  height: 16,
                ),
                TextField(
                    controller: controller.ipprinter0,
                    decoration:
                        InputDecoration(labelText: "IP Printer 1 IP Adress")),
                SizedBox(
                  height: 8,
                ),
                TextField(
                    controller: controller.ipprinter1,
                    decoration:
                        InputDecoration(labelText: "IP Printer 2 IP Adress")),
                SizedBox(
                  height: 8,
                ),
                TextField(
                    controller: controller.ipprinter2,
                    decoration:
                        InputDecoration(labelText: "IP Printer 3 IP Adress")),
                SizedBox(
                  height: 8,
                ),
                TextField(
                    controller: controller.ipprinter3,
                    decoration:
                        InputDecoration(labelText: "IP Printer 4 IP Adress")),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      save.write("btprinter", controller.btprinter.text);
                      save.write("ipprinter0", controller.ipprinter0.text);
                      save.write("ipprinter1", controller.ipprinter1.text);
                      save.write("ipprinter2", controller.ipprinter2.text);
                      save.write("ipprinter3", controller.ipprinter3.text);
                      Get.back();
                    },
                    child: Text("Save")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
