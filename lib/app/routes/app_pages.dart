import 'package:get/get.dart';

import '../modules/bills/bindings/bills_binding.dart';
import '../modules/bills/views/bill_view.dart';
import '../modules/bills/views/bills_view.dart';
import '../modules/cancel/bindings/cancel_binding.dart';
import '../modules/cancel/views/cancel_view.dart';
import '../modules/categories/bindings/categories_binding.dart';
import '../modules/categories/views/categories_view.dart';
import '../modules/fehler/bindings/fehler_binding.dart';
import '../modules/fehler/views/fehler_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/bill_confirm_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/kitchen_confirm_view.dart';
import '../modules/home/views/z_report_confirm_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/views/products_add_view.dart';
import '../modules/products/views/products_extra_view.dart';
import '../modules/products/views/products_partial_view.dart';
import '../modules/products/views/products_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/tables/bindings/tables_binding.dart';
import '../modules/tables/views/tables_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.HOME;
  static const FEHLER = Routes.FEHLER;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TABLES,
      page: () => TablesView(),
      binding: TablesBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTSEXTRA,
      page: () => ProductsExtraView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTSADD,
      page: () => ProductsAddView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTSPARTIAL,
      page: () => ProductsPartialView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIES,
      page: () => CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: _Paths.CANCEL,
      page: () => CancelView(),
      binding: CancelBinding(),
    ),
    GetPage(
      name: _Paths.BILLS,
      page: () => BillsView(),
      binding: BillsBinding(),
    ),
    GetPage(
      name: _Paths.BILL,
      page: () => BillView(),
      binding: BillsBinding(),
    ),
    GetPage(
      name: Routes.ZREPORTCONFIRM,
      page: () => ZReportConfirmView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.BILLCONFIRM,
      page: () => BillConfirmView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.KITCHENCONFIRM,
      page: () => KitchenConfirmView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FEHLER,
      page: () => FehlerView(),
      binding: FehlerBinding(),
    ),
  ];
}
