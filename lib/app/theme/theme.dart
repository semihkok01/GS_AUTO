import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_order_basic/app/theme/colors.dart';

class ThemeService {
  final box = GetStorage();

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => isDarkThemeActive() ? ThemeMode.dark : ThemeMode.light;

  void changeThemeMode(bool val) {
    box.write('isDark', val);
    Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
    //changeSystemBarColors();
  }

  Future<bool> changeSystemBarColors() async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarIconBrightness:
            isDarkThemeActive() ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDarkThemeActive()
            ? AppColors.darkSurface2
            : AppColors.lightSurface2,
      ),
    );
    return true;
  }

  bool isDarkThemeActive() {
    return box.read('isDark') ?? false;
  }
}
