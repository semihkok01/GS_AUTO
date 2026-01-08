import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pos_order_basic/app/routes/app_pages.dart';
import 'package:pos_order_basic/app/theme/theme.dart';
import '../controllers/home_controller.dart';

var depo = GetStorage();

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            // ignore: deprecated_member_use

            title: Text('Restaurant POS SCHULUNG'),
            centerTitle: true,
            actions: [
              // Get Theme Light or Dark
              SimpleBuilder(builder: (_) {
                return IconButton(
                  icon: Icon(ThemeService().isDarkThemeActive()
                      ? Icons.light_mode
                      : Icons.dark_mode),
                  onPressed: () {
                    if (ThemeService().isDarkThemeActive()) {
                      ThemeService().changeThemeMode(false);
                    } else {
                      ThemeService().changeThemeMode(true);
                    }
                  },
                );
              }),
            ],
          ),
          body: SafeArea(
            child: CustomScrollView(
              primary: false,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.TABLES);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.table_restaurant),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Tische",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*   SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.SETTINGS);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.settings_applications),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Einstellungen",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8), */
                      /*  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.BILLS);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.receipt_long),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Rechnungen",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8), */
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Sicher Loeschen ?",
                                content: Container(
                                  width: Get.width * 0.7,
                                  height: Get.height * 0.2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("Nein"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          controller.removeEverythings();
                                        },
                                        child: Text("Ja"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.delete_forever_sharp),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Alles Loeschen",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      /*   Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              bool isAllTablesEmpty = true;
                              List<dynamic> notEmptyTables = [];
                              controller.tables.forEach((table000) {
                                if (table000.products!.isNotEmpty) {
                                  isAllTablesEmpty = false;
                                  notEmptyTables.add(table000.name);
                                }
                              });

                              if (isAllTablesEmpty == false) {
                                Get.snackbar(
                                    "Warnung",
                                    "Tische mit Produkten: " +
                                        notEmptyTables.toString());
                                return;
                              }

                              Get.defaultDialog(
                                title: "Z Bericht Ausdrucken ?",
                                content: Container(
                                  width: Get.width * 0.7,
                                  height: Get.height * 0.2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("Nein"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.getZReport(context);
                                          Get.back();
                                        },
                                        child: Text("Ja"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.receipt_outlined),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Z-Bericht",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.CANCEL);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.cancel_presentation),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Storno",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ), */
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Version: 1.0.4 (5)",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          child: Text(
                            "Imprint",
                          ),
                          onPressed: () {
                            Get.defaultDialog(
                                title: "Imprint",
                                content: Text(
                                    "This application is completely programmed for private use. Company or Commercial use is strictly prohibited. In case of commercial use, all accusations and legal proceedings belong entirely to the user. This application has been developed as open source and is designed for anyone to download and use. For commercial use, please contact your country's Finance or Finance Office to inquire about the legality of your use. All numbers and Products shown in the application are completely unrealistic and imaginary. The application has been made to provide training and training on how sales transactions are carried out in a workplace. Licenses Github afl-3.0 gpl-2.0 unlicense"));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
