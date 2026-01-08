import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pos_order_basic/app/modules/home/controllers/home_controller.dart';
import 'package:pos_order_basic/app/routes/app_pages.dart';

import '../../tables/models/table.dart';

class ProductsView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    int? tableNumber;
    if (Get.arguments != null) {
      if (Get.arguments['table'] != null) {
        tableNumber = Get.arguments['table'];
      }
    }
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bitte klicken Sie auf den Tischnummer'),
          /*   actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Get.defaultDialog(
                  title: "Diverse",
                  content: Container(
                    height: Get.height * 0.25,
                    width: Get.width,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                            Get.defaultDialog(
                                title: "Diverse Küche",
                                content: Container(
                                  // height: Get.height * 0.40,
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: controller
                                            .customProductNameController,
                                        decoration: InputDecoration(
                                            labelText: "Produktname",
                                            hintText:
                                                "Bitte geben Sie einen beliebigen Produktnamen ein"),
                                        onChanged: (value) {},
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          CommaTextInputFormatter(),
                                        ],
                                        controller: controller
                                            .customProductPriceController,
                                        decoration: InputDecoration(
                                            labelText: "Preis",
                                            hintText:
                                                "Bitte geben Sie den Preis ein"),
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                ),
                                onConfirm: () {
                                  controller.createCustomKitchenOrDrink(
                                      1, tableNumber!);
                                },
                                textConfirm: "Senden",
                                onCancel: () {},
                                textCancel: "Abbrechen");
                          },
                          child: Text("Diverse Küche"),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromWidth(Get.width * 0.7),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                            Get.defaultDialog(
                                title: "Diverse Getränke",
                                content: Container(
                                  // height: Get.height * 0.40,
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: controller
                                            .customProductNameController,
                                        decoration: InputDecoration(
                                            labelText: "Produktname",
                                            hintText:
                                                "Bitte geben Sie einen beliebigen Produktnamen ein"),
                                        onChanged: (value) {},
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: [
                                          CommaTextInputFormatter(),
                                        ],
                                        controller: controller
                                            .customProductPriceController,
                                        decoration: InputDecoration(
                                            labelText: "Preis",
                                            hintText:
                                                "Bitte geben Sie den Preis ein"),
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                ),
                                onConfirm: () {
                                  controller.createCustomKitchenOrDrink(
                                      2, tableNumber!);
                                },
                                textConfirm: "Senden",
                                onCancel: () {},
                                textCancel: "Abbrechen");
                          },
                          child: Text("Diverse Getränke"),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size.fromWidth(Get.width * 0.7)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                            Get.defaultDialog(
                                title: "Nachricht",
                                content: Container(
                                  // height: Get.height * 0.40,
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        maxLines: 2,
                                        controller:
                                            controller.customNoteController,
                                        decoration: InputDecoration(
                                            labelText: "Nachricht",
                                            hintText:
                                                "Bitte geben Sie einen beliebigen Nachricht ein"),
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                ),
                                onConfirm: () {
                                  controller.createNote(
                                    2,
                                  );
                                },
                                textConfirm: "Senden",
                                onCancel: () {},
                                textCancel: "Abbrechen");
                          },
                          child: Text("Nachricht"),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size.fromWidth(Get.width * 0.7)),
                        ),
                      ],
                    ),
                  ),
                );
              },
          ),
          ], */
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                /*   Text(
                  "Produkte",
                  style: TextStyle(fontSize: 30),
                ), */
                SizedBox(
                  height: 8,
                ),
                GetBuilder<HomeController>(initState: (_) {
                  if (tableNumber != null) {
                    Get.find<HomeController>().getCurrentTable(tableNumber);
                  }
                }, builder: (controller) {
                  if (controller.currentTable.total != null) {
                    return Column(
                      children: [
                        Text(
                          "${controller.currentTable.name}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.error),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${controller.currentTable.total!.toStringAsFixed(2)} €",
                          style: /* Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.error),
                          textAlign: TextAlign.center, */
                              TextStyle(fontSize: 60, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        if (controller.currentTable.totalNotPaid != 0.00 &&
                            (controller.currentTable
                                    .partialPaidConfirmedProducts !=
                                []) &&
                            controller.currentTable.totalNotPaid !=
                                controller.currentTable.total)
                          Text(
                            "Offen: ${(controller.currentTable.totalNotPaid!).toStringAsFixed(2)} €",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context).colorScheme.error),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    );
                  } else {
                    return GFLoader();
                  }
                }),
                SizedBox(
                  height: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        child: Row(
                          children: [
                            if (!(controller.currentTable.totalNotPaid !=
                                    0.00 &&
                                (controller.currentTable
                                        .partialPaidConfirmedProducts !=
                                    []) &&
                                controller.currentTable.totalNotPaid !=
                                    controller.currentTable.total))
                              Flexible(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "Sicher Abschliessen?",
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () => Get.back(),
                                            child: Text("Nein"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              // Create Unique Bill Number
                                              String billNumber =
                                                  controller.createBillNumber();
                                              String certificateNumber =
                                                  controller
                                                      .createCertificateNumber();

                                              // Create Bill
                                              bool status = await controller
                                                  .printWithoutBluetooth(
                                                      context,
                                                      billNumber,
                                                      certificateNumber,
                                                      false);

                                              if (status) {
                                                // Add products of current table to z-report
                                              }
                                            },
                                            child: Text("Ja"),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.payment,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Bezahlen",
                                        style: TextStyle(
                                            fontSize: Get.width * 0.06),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(
                                    Routes.PRODUCTSPARTIAL,
                                    arguments: {"table": tableNumber},
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.payment,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Getrennt",
                                      style:
                                          TextStyle(fontSize: Get.width * 0.06),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: Container(
                    //     child: ElevatedButton(
                    //       onPressed: () {
                    //         Get.defaultDialog(
                    //           title: "Sicher Abschliessen?",
                    //           content: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceAround,
                    //             children: [
                    //               ElevatedButton(
                    //                 onPressed: () => Get.back(),
                    //                 child: Text("Nein"),
                    //               ),
                    //               ElevatedButton(
                    //                 onPressed: () async {
                    //                   // Create Unique Bill Number
                    //                   String billNumber =
                    //                       controller.createBillNumber();
                    //                   String certificateNumber =
                    //                       controller.createCertificateNumber();

                    //                   Get.back();

                    //                   // Create Bill
                    //                   bool status =
                    //                       await controller.printWithBluetooth(
                    //                           context,
                    //                           billNumber,
                    //                           certificateNumber,
                    //                           false);

                    //                   if (status) {
                    //                     // Add products of current table to z-report

                    //                   }
                    //                 },
                    //                 child: Text("Ja"),
                    //               )
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Icon(
                    //               Icons.print,
                    //             ),
                    //             SizedBox(
                    //               width: 8,
                    //             ),
                    //             Text(
                    //               "Rechnung Ausdrucken",
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    /*  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.printWithWifi(context);
                            // Get.snackbar("Bestellung an der Küche Gesendet",
                            //     "Status : Küche Vorbereitung");
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.send),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Küche Senden",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ), */
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                //InkWell(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: Get.width,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: "Fleisch",
                                  content: Container(
                                    height: Get.height * 0.6,
                                    width: Get.width,
                                    child: Column(
                                      children: [
                                        /*  ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee':
                                                      controller.buns
                                                });
                                          },
                                          child: Text("Diverse Küche"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ), */
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee': controller.buns
                                                });
                                          },
                                          child: Text("Buns"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee': controller.sandbuns
                                                });
                                          },
                                          child: Text("Sandbuns"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee': controller.bowls
                                                });
                                          },
                                          child: Text("Bowls"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee': controller.beilagen
                                                });
                                          },
                                          child: Text("Beilagen"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee':
                                                      controller.hausgemacht
                                                });
                                          },
                                          child: Text("H.G. Saucen"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee': controller.sweets
                                                });
                                          },
                                          child: Text("Sweets"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee':
                                                      controller.bunsupgrade
                                                });
                                          },
                                          child: Text("Buns Upgrade"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                            child: Text(
                              "Essen",
                              style: TextStyle(fontSize: Get.width * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: "Drinks",
                                  content: Container(
                                    height: Get.height * 0.6,
                                    width: Get.width,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee':
                                                        controller.softdrinks
                                                  });
                                            },
                                            child: Text("Softdrinks"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee': controller.safte
                                                  });
                                            },
                                            child: Text("Säfte&Schorlen"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee': controller.icetea
                                                  });
                                            },
                                            child: Text("ICE-Tea"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee':
                                                        controller.hotdrinks
                                                  });
                                            },
                                            child: Text("Hotdrinks"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee': controller.wein
                                                  });
                                            },
                                            child: Text("Wein&Spritzig"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                        /*   ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee': controller.fass
                                                  });
                                            },
                                            child: Text("Fassbier"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ), */
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee': controller.fass
                                                  });
                                            },
                                            child: Text("Fassbier"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee':
                                                        controller.flaschen
                                                  });
                                            },
                                            child: Text("Flaschenbier"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee':
                                                        controller.cocktails
                                                  });
                                            },
                                            child: Text("Cocktails"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee':
                                                        controller.mocktails
                                                  });
                                            },
                                            child: Text("Mocktails"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee':
                                                        controller.highballs
                                                  });
                                            },
                                            child: Text("Highballs"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee': controller.mules
                                                  });
                                            },
                                            child: Text("Mules"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.toNamed(Routes.PRODUCTSADD,
                                                  arguments: {
                                                    'table': tableNumber,
                                                    'nominee': controller.shots
                                                  });
                                            },
                                            child: Text("Shoots"),
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: Size.fromWidth(
                                                    Get.width * 0.7)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                            child: Text(
                              "Trinken",
                              style: TextStyle(fontSize: Get.width * 0.06),
                            ),
                          ),
                        ),
/*                         Container(
                          padding: const EdgeInsets.all(3),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: "Getränke",
                                  content: Container(
                                    height: Get.height * 0.55,
                                    width: Get.width,
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee':
                                                      controller.kaltegetranke
                                                });
                                          },
                                          child: Text("Getränke"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee':
                                                      controller.heisegetranke
                                                });
                                          },
                                          child: Text("Heise Getränke"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee':
                                                      controller.extrasmenu
                                                });
                                          },
                                          child: Text("Extras"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(Routes.PRODUCTSADD,
                                                arguments: {
                                                  'table': tableNumber,
                                                  'nominee': controller.desserts
                                                });
                                          },
                                          child: Text("Desserts"),
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size.fromWidth(
                                                  Get.width * 0.7)),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                            child: Text(
                              "Drink-Extra",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ), */
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Bestellungen",
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: 8,
                ),
                GetBuilder<HomeController>(initState: (_) {
                  if (tableNumber != null) {
                    Get.find<HomeController>().getCurrentTable(tableNumber);
                  }
                }, builder: (controller) {
                  if (controller.currentTable.products != null) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.currentTable.products!.length,
                      itemBuilder: (context, index) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller
                              .currentTable.products![index].products!.length,
                          itemBuilder: (context, j) {
                            return ListTile(
                              isThreeLine: (controller
                                              .currentTable
                                              .products![index]
                                              .products![j]
                                              .extras !=
                                          null &&
                                      controller.currentTable.products![index]
                                          .products![j].extras!.isNotEmpty)
                                  ? true
                                  : false,
                              title: Text(
                                controller.currentTable.products![index]
                                    .products![j].name!,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.currentTable.products![index]
                                            .products![j].price!
                                            .toStringAsFixed(2) +
                                        " €",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  if (controller.currentTable.products![index]
                                              .products![j].extras !=
                                          null &&
                                      controller.currentTable.products![index]
                                          .products![j].extras!.isNotEmpty)
                                    Text(
                                      "${(controller.currentTable.products![index].products![j].extras!.map((element) {
                                        return element.content! +
                                            " " +
                                            (element.status == true ? "" : "");
                                      }).join(", "))}",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                ],
                              ),
                              trailing: Container(
                                width: Get.width * 0.35,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: IconButton(
                                          icon: Icon(Icons.add, size: 30),
                                          onPressed: () {
                                            controller.addProduct2Table(
                                                tableNumber,
                                                controller
                                                    .currentTable
                                                    .products![index]
                                                    .products![j],
                                                2);
                                          }),
                                    ),
                                    Flexible(
                                      child: IconButton(
                                        icon: Icon(Icons.edit, size: 30),
                                        onPressed: () {
                                          TableModel table = controller.tables
                                              .firstWhere((element) =>
                                                  element.id == tableNumber);
                                          int productListObj = table.products!
                                              .indexWhere((element) =>
                                                  element.product!.id ==
                                                  controller
                                                      .currentTable
                                                      .products![index]
                                                      .product!
                                                      .id);
                                          int lastIndex = table.products!
                                              .firstWhere((element) =>
                                                  element.product!.id ==
                                                  controller
                                                      .currentTable
                                                      .products![index]
                                                      .product!
                                                      .id)
                                              .products!
                                              .indexOf(controller
                                                  .currentTable
                                                  .products![index]
                                                  .products![j]);
                                          Get.toNamed(Routes.PRODUCTSEXTRA,
                                              arguments: {
                                                "table": tableNumber,
                                                "productList": productListObj,
                                                "product": lastIndex
                                              });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: IconButton(
                                        icon: Icon(Icons.delete, size: 30),
                                        onPressed: () {
                                          controller.removeProduct2Table(
                                              tableNumber,
                                              controller
                                                  .currentTable
                                                  .products![index]
                                                  .products![j]);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return SizedBox();
                }),
                GetBuilder<HomeController>(
                  initState: (_) {},
                  builder: (controller) {
                    if (controller.currentTable.note != null) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Nachricht: ${controller.currentTable.note}",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
