import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cancel_controller.dart';

class CancelView extends GetView<CancelController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storno'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Bitte geben Sie den Betrag ein',
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Betrag bspl. 3.50',
              ),
              keyboardType: TextInputType.number,
              controller: controller.betrag,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Erklärung-Warum Storno ? ',
              ),
              controller: controller.notiz,
              maxLines: 4,
            ),
            ElevatedButton(
                onPressed: () async {
                  print("STORNO BETRAG: " + controller.betrag.text);
                  print("STORNO ERKLÄRUNG: " + controller.notiz.text);

                  await controller.storno(double.parse(controller.betrag.text),
                      controller.notiz.text);
                },
                child: Text("Stornieren")),
          ],
        ),
      ),
    );
  }
}
