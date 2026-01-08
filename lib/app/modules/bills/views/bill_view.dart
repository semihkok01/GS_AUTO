import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pos_order_basic/app/modules/home/controllers/home_controller.dart';
import 'package:pos_order_basic/app/theme/filled_button.dart';

class BillView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    int? tableNumber;
    if (Get.arguments != null) {
      if (Get.arguments['table'] != null) {
        tableNumber = Get.arguments['table'];
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("" + ' - Bitte klicken Sie auf den Tischnummer'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              /*   Text(
                "Produkte",
                style: TextStyle(fontSize: 30),
              ), */
              GetBuilder<HomeController>(initState: (_) {
                if (tableNumber != null) {
                  Get.find<HomeController>().getCurrentBill(tableNumber);
                }
              }, builder: (controller) {
                if (controller.currentBill.partialPaidConfirmedProducts !=
                        null &&
                    controller.currentBill.partialPaidConfirmedProducts != []) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${controller.currentBill.name}\nSumme: ${controller.currentBill.totalPaid!.toStringAsFixed(2)} €",
                      style: TextStyle(fontSize: 25, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (controller.currentBill.total != null) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${controller.currentBill.name}\nSumme: ${controller.currentBill.total!.toStringAsFixed(2)} €",
                      style: TextStyle(fontSize: 25, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return GFLoader();
                }
              }),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 64,
                      child: M3FilledButton(
                        onPressed: () async {
                          bool status =
                              await controller.returnAllProductFromBill2ZReport(
                            tableNumber!,
                            controller.currentBill.name!,
                            controller.currentBill.name!.split('Tisch ')[1],
                          );

                          if (status) {
                            // All products returned
                            Get.snackbar(
                              "Erfolg",
                              "Alle Produkte wurden zurückgegeben",
                              backgroundColor: Colors.green,
                              borderRadius: 10,
                              margin: EdgeInsets.all(10),
                              borderColor: Colors.green,
                            );
                          }
                        },
                        icon: Icon(
                          Icons.assignment_returned,
                        ),
                        text: "Rechnung Komplett Stornieren",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
              Text(
                "Bestellungen",
                style: TextStyle(fontSize: 40),
              ),
              GetBuilder<HomeController>(initState: (_) {
                if (tableNumber != null) {
                  Get.find<HomeController>().getCurrentBill(tableNumber);
                }
              }, builder: (controller) {
                if (controller.currentBill.partialPaidConfirmedProducts !=
                        null &&
                    controller.currentBill.partialPaidConfirmedProducts != []) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller
                        .currentBill.partialPaidConfirmedProducts!.length,
                    itemBuilder: (context, index) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller
                            .currentBill
                            .partialPaidConfirmedProducts![index]
                            .products!
                            .length,
                        itemBuilder: (context, j) {
                          return ListTile(
                            isThreeLine: true,
                            title: Text(
                              controller
                                  .currentBill
                                  .partialPaidConfirmedProducts![index]
                                  .products![j]
                                  .name!,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller
                                          .currentBill
                                          .partialPaidConfirmedProducts![index]
                                          .products![j]
                                          .price!
                                          .toStringAsFixed(2) +
                                      " €",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "${(controller.currentBill.partialPaidConfirmedProducts![index].products![j].extras != null && controller.currentBill.partialPaidConfirmedProducts![index].products![j].extras!.isNotEmpty ? (controller.currentBill.partialPaidConfirmedProducts![index].products![j].extras!.map((element) {
                                      return element.content! +
                                          " " +
                                          (element.status == true ? "" : "");
                                    }).join(", ")) : "")}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            trailing: Container(
                              width: Get.width * 0.30,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 38,
                                  ),
                                  GetBuilder<HomeController>(
                                    initState: (_) {},
                                    builder: (_) {
                                      return Flexible(
                                        child: Visibility(
                                          visible: controller
                                                      .currentBill
                                                      .partialPaidConfirmedProducts![
                                                          index]
                                                      .products![j]
                                                      .returned ==
                                                  false ||
                                              controller
                                                      .currentBill
                                                      .partialPaidConfirmedProducts![
                                                          index]
                                                      .products![j]
                                                      .returned ==
                                                  null,
                                          child: IconButton(
                                            icon: Icon(
                                                Icons.assignment_return_rounded,
                                                size: 30),
                                            onPressed: () async {
                                              bool status = await controller
                                                  .returnProduct2ZReport(
                                                controller
                                                    .currentBill
                                                    .partialPaidConfirmedProducts![
                                                        index]
                                                    .products![j],
                                                tableNumber!,
                                                controller.currentBill.name!,
                                                controller.currentBill.name!
                                                    .split('Tisch ')[1],
                                                index,
                                                j,
                                              );

                                              if (status) {
                                                Get.snackbar(
                                                    "Produkt zurückgegeben",
                                                    "Produkt wurde erfolgreich zurückgegeben",
                                                    backgroundColor:
                                                        Colors.green,
                                                    borderRadius: 10,
                                                    margin: EdgeInsets.all(10),
                                                    icon: Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ));
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (controller.currentBill.products != null) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.currentBill.products!.length,
                    itemBuilder: (context, index) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller
                            .currentBill.products![index].products!.length,
                        itemBuilder: (context, j) {
                          return ListTile(
                            isThreeLine: true,
                            title: Text(
                              controller.currentBill.products![index]
                                  .products![j].name!,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.currentBill.products![index]
                                          .products![j].price!
                                          .toStringAsFixed(2) +
                                      " €",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "${(controller.currentBill.products![index].products![j].extras != null && controller.currentBill.products![index].products![j].extras!.isNotEmpty ? (controller.currentBill.products![index].products![j].extras!.map((element) {
                                      return element.content! +
                                          " " +
                                          (element.status == true ? "" : "");
                                    }).join(", ")) : "")}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            trailing: Container(
                              width: Get.width * 0.30,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 38,
                                  ),
                                  GetBuilder<HomeController>(
                                    initState: (_) {},
                                    builder: (_) {
                                      return Flexible(
                                        child: Visibility(
                                          visible: controller
                                                      .currentBill
                                                      .products![index]
                                                      .products![j]
                                                      .returned ==
                                                  false ||
                                              controller
                                                      .currentBill
                                                      .products![index]
                                                      .products![j]
                                                      .returned ==
                                                  null,
                                          child: IconButton(
                                            icon: Icon(
                                                Icons.assignment_return_rounded,
                                                size: 30),
                                            onPressed: () async {
                                              bool status = await controller
                                                  .returnProduct2ZReport(
                                                controller
                                                    .currentBill
                                                    .products![index]
                                                    .products![j],
                                                tableNumber!,
                                                controller.currentBill.name!,
                                                controller.currentBill.name!
                                                    .split('Tisch ')[1],
                                                index,
                                                j,
                                              );

                                              if (status) {
                                                Get.snackbar(
                                                    "Produkt zurückgegeben",
                                                    "Produkt wurde erfolgreich zurückgegeben",
                                                    backgroundColor:
                                                        Colors.green,
                                                    borderRadius: 10,
                                                    margin: EdgeInsets.all(10),
                                                    icon: Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ));
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    },
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
            ],
          ),
        ),
      ),
    );
  }
}
