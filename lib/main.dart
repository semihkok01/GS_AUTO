import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_order_basic/app/theme/theme.dart';

import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';

var depo = GetStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String mesaj = "false";
  try {
    final response =
        await Dio().get('https://mobil-dershane.com/license/license-buns.php');
    //print(response);
    print(response.data);
    mesaj = response.data?.toString().trim() ?? "false";
  } catch (e) {
    print(e);
  }
  if (mesaj == "true") {
    try {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ]).then((_) {
        runApp(
          GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "POS Order Basic",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeService().theme,
          ),
        );
      });
      await GetStorage.init();
      depo.writeIfNull("zvurulan", 0.00);
      depo.writeIfNull("ztoplam", 0.00);

      print("License Valid");
    } catch (e) {
      print(e);
    }
  } else if (mesaj == "false") {
    /*  Get.toNamed(Routes.FEHLER); */
    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "POS Order Basic",
        initialRoute: AppPages.FEHLER,
        getPages: AppPages.routes,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeService().theme,
      ),
    );

    print("License Invalid");
  }
}
