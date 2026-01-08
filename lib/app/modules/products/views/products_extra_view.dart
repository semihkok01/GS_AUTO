import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_order_basic/app/modules/home/controllers/home_controller.dart';
import 'package:pos_order_basic/app/theme/filled_button.dart';

class ProductsExtraView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    late int productList;
    late int currentProduct;
    late int tableNumber;
    if (Get.arguments != null) {
      if (Get.arguments['productList'] != null) {
        productList = Get.arguments['productList'];
      }
      if (Get.arguments['product'] != null) {
        currentProduct = Get.arguments['product'];
      }
      if (Get.arguments['table'] != null) {
        tableNumber = Get.arguments['table'];
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Extras'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.size.width * .05),
              child: GetBuilder<HomeController>(
                initState: (_) {},
                builder: (_) {
                  return Text(
                    "Produkte: ${controller.tables[tableNumber].products![productList].products![currentProduct].name}",
                    style: TextStyle(fontSize: 22),
                    textAlign: TextAlign.left,
                  );
                },
              ),
            ),
            // GetBuilder<HomeController>(
            //   initState: (_) {},
            //   builder: (controller) {
            //     return Padding(
            //       padding: EdgeInsets.symmetric(
            //           horizontal: Get.size.width * .05, vertical: 5),
            //       child: GetBuilder<HomeController>(
            //         initState: (_) {},
            //         builder: (_) {
            //           return Text(
            //             "$tableNumber $currentProduct $productList",
            //             style: TextStyle(fontSize: 20),
            //             textAlign: TextAlign.left,
            //           );
            //         },
            //       ),
            //     );
            //   },
            // ),
            GetBuilder<HomeController>(
              initState: (_) {},
              builder: (controller) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.size.width * .05, vertical: 5),
                  child: GetBuilder<HomeController>(
                    initState: (_) {},
                    builder: (_) {
                      return Text(
                        "${(controller.tables[tableNumber].products![productList].products![currentProduct].extras != null && controller.tables[tableNumber].products![productList].products![currentProduct].extras!.isNotEmpty ? (controller.tables[tableNumber].products![productList].products![currentProduct].extras!.map((element) {
                            return element.content!
                                // +
                                // " " +
                                // (element.status == true
                                //     ? "İstiyor"
                                //     : "İstemiyor")
                                ;
                          }).join(", ")) : "")}",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.left,
                      );
                    },
                  ),
                );
              },
            ),
            GetBuilder<HomeController>(
                initState: (_) {},
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.size.width * .05, vertical: 8),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('OK'),
                            ),
                          ),
                        ),
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.extraCategories.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.size.width * .05,
                                    vertical: 5),
                                child: GetBuilder<HomeController>(
                                  initState: (_) {},
                                  builder: (_) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.extraCategories[i]!,
                                          style: TextStyle(fontSize: 18),
                                          textAlign: TextAlign.left,
                                        ),
                                        Container(
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 4,
                                                    mainAxisSpacing: 8,
                                                    crossAxisSpacing: 8),
                                            itemBuilder: (context, index) {
                                              return GetBuilder<HomeController>(
                                                initState: (_) {},
                                                builder: (controller) {
                                                  return M3FilledButton(
                                                    text: controller.extras
                                                        .where((element) =>
                                                            element.category ==
                                                            controller
                                                                .extraCategories[i]!)
                                                        .toList()[index]
                                                        .content!,
                                                    onPressed: () {
                                                      controller.changeStatus(
                                                          tableNumber,
                                                          productList,
                                                          currentProduct,
                                                          i,
                                                          index,
                                                          true);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            itemCount: controller.extras
                                                .where((element) =>
                                                    element.category ==
                                                    controller
                                                        .extraCategories[i]!)
                                                .toList()
                                                .length,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Get.size.width * .05, vertical: 5),
            //   child: GetBuilder<HomeController>(
            //     initState: (_) {},
            //     builder: (_) {
            //       return Text(
            //         "Malzeme Çıkar",
            //         style: TextStyle(fontSize: 20),
            //         textAlign: TextAlign.left,
            //       );
            //     },
            //   ),
            // ),
            // GetBuilder<HomeController>(
            //   initState: (_) {},
            //   builder: (controller) {
            //     return Padding(
            //       padding:
            //           EdgeInsets.symmetric(horizontal: Get.size.width * .05),
            //       child: Container(
            //         height: Get.size.height * .2,
            //         child: GridView.builder(
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 2,
            //               childAspectRatio: 4,
            //               mainAxisSpacing: 10,
            //               crossAxisSpacing: 10),
            //           itemBuilder: (context, index) {
            //             return GetBuilder<HomeController>(
            //               initState: (_) {},
            //               builder: (controller) {
            //                 if (controller
            //                             .tables[tableNumber]
            //                             .products![productList]
            //                             .products![currentProduct]
            //                             .extras ==
            //                         null ||
            //                     controller
            //                         .tables[tableNumber]
            //                         .products![productList]
            //                         .products![currentProduct]
            //                         .extras!
            //                         .where((element) =>
            //                             element.content ==
            //                                 controller.extras[index].content &&
            //                             element.status == true)
            //                         .isEmpty) {
            //                   return ElevatedButton(
            //                     style: ElevatedButton.styleFrom(
            //                         primary: Colors.cyan),
            //                     child: Text(controller.extras[index].content!),
            //                     onPressed: () {
            //                       controller.changeStatus(
            //                           tableNumber,
            //                           productList,
            //                           currentProduct,
            //                           index,
            //                           false);
            //                     },
            //                   );
            //                 } else {
            //                   return SizedBox();
            //                 }
            //               },
            //             );
            //           },
            //           shrinkWrap: true,
            //           itemCount: controller.extras.length,
            //         ),
            //       ),
            //     );
            //   },
            // ),

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.size.width * .05, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('OK'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
