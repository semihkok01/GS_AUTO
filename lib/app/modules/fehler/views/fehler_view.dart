import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/fehler_controller.dart';

class FehlerView extends GetView<FehlerController> {
  const FehlerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'System Fehler : Lizenz nicht gefunden',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
