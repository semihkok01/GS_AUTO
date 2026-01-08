import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pos_order_basic/app/modules/home/controllers/home_controller.dart';


class ProductsPartialView extends GetView<HomeController> {
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
          title: Text('Getrennt Zahlung'),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "${controller.currentTable.name}",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Theme.of(context).colorScheme.error),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Center(
                          child: Text(
                            "${controller.currentTable.total!.toStringAsFixed(2)} €",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context).colorScheme.error),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    );
                  } else {
                    return GFLoader();
                  }
                }),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Bitte wählen Sie die Produkte aus:",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GetBuilder<HomeController>(
                  initState: (_) {
                    if (tableNumber != null) {
                      //Get.find<HomeController>().getCurrentTable(tableNumber);
                      controller.initPartial(tableNumber);
                    }
                  },
                  builder: (controller) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller
                          .currentTable.partialNotPaidProducts!.length,
                      itemBuilder: (context, index) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.currentTable
                              .partialNotPaidProducts![index].products!.length,
                          itemBuilder: (context, j) {
                            return ListTile(
                              isThreeLine: (controller
                                              .currentTable
                                              .partialNotPaidProducts![index]
                                              .products![j]
                                              .extras !=
                                          null &&
                                      controller
                                          .currentTable
                                          .partialNotPaidProducts![index]
                                          .products![j]
                                          .extras!
                                          .isNotEmpty)
                                  ? true
                                  : false,
                              title: Text(
                                controller
                                    .currentTable
                                    .partialNotPaidProducts![index]
                                    .products![j]
                                    .name!,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller
                                            .currentTable
                                            .partialNotPaidProducts![index]
                                            .products![j]
                                            .price!
                                            .toStringAsFixed(2) +
                                        " €",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  if (controller
                                              .currentTable
                                              .partialNotPaidProducts![index]
                                              .products![j]
                                              .extras !=
                                          null &&
                                      controller
                                          .currentTable
                                          .partialNotPaidProducts![index]
                                          .products![j]
                                          .extras!
                                          .isNotEmpty)
                                    Text(
                                      "${(controller.currentTable.partialNotPaidProducts![index].products![j].extras!.map((element) {
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
                                width: Get.width * 0.15,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: IconButton(
                                          icon: Icon(Icons.add, size: 30),
                                          onPressed: () {
                                            controller.addProduct2PartialTable(
                                                tableNumber,
                                                controller
                                                    .currentTable
                                                    .partialNotPaidProducts![
                                                        index]
                                                    .products![j],
                                                2);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Ausgewählte Produkte:",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.start,
                  ),
                ),
                GetBuilder<HomeController>(
                  initState: (_) {},
                  builder: (controller) {
                    if (controller.currentTable.partialPaidProducts != null) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            controller.currentTable.partialPaidProducts!.length,
                        itemBuilder: (context, index) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.currentTable
                                .partialPaidProducts![index].products!.length,
                            itemBuilder: (context, j) {
                              return ListTile(
                                isThreeLine: (controller
                                                .currentTable
                                                .partialPaidProducts![index]
                                                .products![j]
                                                .extras !=
                                            null &&
                                        controller
                                            .currentTable
                                            .partialPaidProducts![index]
                                            .products![j]
                                            .extras!
                                            .isNotEmpty)
                                    ? true
                                    : false,
                                title: Text(
                                  controller
                                      .currentTable
                                      .partialPaidProducts![index]
                                      .products![j]
                                      .name!,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller
                                              .currentTable
                                              .partialPaidProducts![index]
                                              .products![j]
                                              .price!
                                              .toStringAsFixed(2) +
                                          " €",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    if (controller
                                                .currentTable
                                                .partialPaidProducts![index]
                                                .products![j]
                                                .extras !=
                                            null &&
                                        controller
                                            .currentTable
                                            .partialPaidProducts![index]
                                            .products![j]
                                            .extras!
                                            .isNotEmpty)
                                      Text(
                                        "${(controller.currentTable.partialPaidProducts![index].products![j].extras!.map((element) {
                                          return element.content! +
                                              " " +
                                              (element.status == true
                                                  ? ""
                                                  : "");
                                        }).join(", "))}",
                                        style:
                                            Theme.of(context).textTheme.bodySmall,
                                      ),
                                  ],
                                ),
                                trailing: Container(
                                  width: Get.width * 0.15,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: IconButton(
                                            icon: Icon(Icons.remove, size: 30),
                                            onPressed: () {
                                              controller
                                                  .removeProductFromPartialTable(
                                                      tableNumber,
                                                      controller
                                                          .currentTable
                                                          .partialPaidProducts![
                                                              index]
                                                          .products![j],
                                                      2);
                                            }),
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
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(),
                ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Betrag: ${controller.currentTable.totalWillPay!.toStringAsFixed(2)} €",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context).colorScheme.error),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    );
                  } else {
                    return GFLoader();
                  }
                }),
                SizedBox(
                  height: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        child: ElevatedButton(
                          onPressed: () async {
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
                                      await controller.confirmPartialPayment(
                                          tableNumber, context);

                                      // Create Unique Bill Number
                                      String billNumber =
                                          controller.createBillNumber();
                                      String certificateNumber =
                                          controller.createCertificateNumber();

                                      Get.back();

                                      // Create Bill
                                      bool status = await controller
                                          .printWithoutBluetooth(
                                              context,
                                              billNumber,
                                              certificateNumber,
                                              true);

                                      if (status) {}
                                    },
                                    child: Text("Ja"),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                  "Bestätigen",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Text(
                //     "Ödenmiş Ürünler:",
                //     style: Theme.of(context).textTheme.bodyMedium,
                //     textAlign: TextAlign.start,
                //   ),
                // ),
                // GetBuilder<HomeController>(
                //   initState: (_) {},
                //   builder: (controller) {
                //     if (controller.currentTable.partialPaidConfirmedProducts !=
                //         null) {
                //       return ListView.builder(
                //         physics: NeverScrollableScrollPhysics(),
                //         shrinkWrap: true,
                //         itemCount: controller
                //             .currentTable.partialPaidConfirmedProducts!.length,
                //         itemBuilder: (context, index) {
                //           return ListView.builder(
                //             physics: NeverScrollableScrollPhysics(),
                //             shrinkWrap: true,
                //             itemCount: controller
                //                 .currentTable
                //                 .partialPaidConfirmedProducts![index]
                //                 .products!
                //                 .length,
                //             itemBuilder: (context, j) {
                //               return ListTile(
                //                 isThreeLine: (controller
                //                                 .currentTable
                //                                 .partialPaidConfirmedProducts![
                //                                     index]
                //                                 .products![j]
                //                                 .extras !=
                //                             null &&
                //                         controller
                //                             .currentTable
                //                             .partialPaidConfirmedProducts![
                //                                 index]
                //                             .products![j]
                //                             .extras!
                //                             .isNotEmpty)
                //                     ? true
                //                     : false,
                //                 title: Text(
                //                   controller
                //                       .currentTable
                //                       .partialPaidConfirmedProducts![index]
                //                       .products![j]
                //                       .name!,
                //                   style: Theme.of(context).textTheme.labelLarge,
                //                 ),
                //                 subtitle: Column(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       controller
                //                               .currentTable
                //                               .partialPaidConfirmedProducts![
                //                                   index]
                //                               .products![j]
                //                               .price!
                //                               .toStringAsFixed(2) +
                //                           " €",
                //                       style:
                //                           Theme.of(context).textTheme.bodyLarge,
                //                     ),
                //                     if (controller
                //                                 .currentTable
                //                                 .partialPaidConfirmedProducts![
                //                                     index]
                //                                 .products![j]
                //                                 .extras !=
                //                             null &&
                //                         controller
                //                             .currentTable
                //                             .partialPaidConfirmedProducts![
                //                                 index]
                //                             .products![j]
                //                             .extras!
                //                             .isNotEmpty)
                //                       Text(
                //                         "${(controller.currentTable.partialPaidConfirmedProducts![index].products![j].extras!.map((element) {
                //                           return element.content! +
                //                               " " +
                //                               (element.status == true
                //                                   ? ""
                //                                   : "");
                //                         }).join(", "))}",
                //                         style:
                //                             Theme.of(context).textTheme.caption,
                //                       ),
                //                   ],
                //                 ),
                //                 trailing: Container(
                //                   width: Get.width * 0.15,
                //                   child: Row(
                //                     children: [
                //                       Flexible(
                //                         child: IconButton(
                //                             icon: Icon(Icons.remove, size: 30),
                //                             onPressed: () {
                //                               controller
                //                                   .removeProductFromPartialTable(
                //                                       tableNumber,
                //                                       controller
                //                                           .currentTable
                //                                           .partialPaidConfirmedProducts![
                //                                               index]
                //                                           .products![j],
                //                                       2);
                //                             }),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             },
                //           );
                //         },
                //       );
                //     }
                //     return SizedBox();
                //   },
                // ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
