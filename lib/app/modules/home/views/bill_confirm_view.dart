import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pos_order_basic/app/modules/home/controllers/home_controller.dart';
import 'package:pos_order_basic/app/routes/app_pages.dart';

class BillConfirmView extends GetView<HomeController> {
  //late DateTime currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? detail;

    if (Get.arguments != null) {
      detail = Get.arguments['detail'];
      print(detail);
    }

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: LoaderOverlay(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Rechnung'),
            centerTitle: true,
            actions: [],
          ),
          body: SafeArea(
            child: CustomScrollView(
              primary: false,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 16),
                      GetBuilder<HomeController>(builder: (controller) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Text(
                                "Table: ${detail?['table']}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(height: 8),
                              Divider(),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: detail?['products'].length,
                                itemBuilder: (context, j) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(detail?['products'][j]["name"],
                                          style: TextStyle(
                                              fontSize: Get.width * 0.06)),
                                      Text(detail?['products'][j]['price'],
                                          style: TextStyle(
                                              fontSize: Get.width * 0.06)),
                                    ],
                                  );
                                },
                              ),
                              Divider(),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "MwSt %19",
                                    style:
                                        TextStyle(fontSize: Get.width * 0.06),
                                  ),
                                  Text(detail?['nwst19'],
                                      style: TextStyle(
                                          fontSize: Get.width * 0.06)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "UMSATZ %19",
                                    style:
                                        TextStyle(fontSize: Get.width * 0.06),
                                  ),
                                  Text(detail?['umsatz19'],
                                      style: TextStyle(
                                          fontSize: Get.width * 0.06)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "MwSt. %7",
                                    style:
                                        TextStyle(fontSize: Get.width * 0.06),
                                  ),
                                  Text(detail?['nwst7'],
                                      style: TextStyle(
                                          fontSize: Get.width * 0.06)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "UMSATZ %7",
                                    style:
                                        TextStyle(fontSize: Get.width * 0.06),
                                  ),
                                  Text(detail?['umsatz7'],
                                      style: TextStyle(
                                          fontSize: Get.width * 0.06)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TOTAL",
                                    style:
                                        TextStyle(fontSize: Get.width * 0.06),
                                  ),
                                  Text(detail?['total'],
                                      style: TextStyle(
                                          fontSize: Get.width * 0.06)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "BAR",
                                    style:
                                        TextStyle(fontSize: Get.width * 0.06),
                                  ),
                                  Text(detail?['bar'],
                                      style: TextStyle(
                                          fontSize: Get.width * 0.06)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "DATUM",
                                    style:
                                        TextStyle(fontSize: Get.width * 0.06),
                                  ),
                                  Text(
                                    detail?['datum'],
                                    style:
                                        TextStyle(fontSize: Get.width * 0.06),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                "${detail?['transaktion']}",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "${detail?['zertifikat']}",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "${detail?['billNumber']}",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: Size.infinite.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Expanded(
                                    //   child: ElevatedButton(
                                    //     onPressed: () async {
                                    //       await controller
                                    //           .printWithoutBluetooth(
                                    //               context,
                                    //               Get.arguments["billNumber"],
                                    //               Get.arguments[
                                    //                   "certificateNumber"],
                                    //               Get.arguments["isPartial"]);
                                    //     },
                                    //     child: Text("Nein"),
                                    //   ),
                                    // ),
                                    // SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.add2BillsList(
                                              controller.currentTable.copyWith(
                                                  name: Get.arguments[
                                                          "billNumber"] +
                                                      " " +
                                                      controller
                                                          .currentTable.name!),
                                              Get.arguments["isPartial"]);
                                          controller.billPrinted++;
                                          controller.depo.write("billPrinted",
                                              controller.billPrinted);
                                          controller.update();
                                          if (Get.arguments["isPartial"]) {
                                            print("Heyoo");
                                            print(controller.currentTable
                                                .partialNotPaidProducts);
                                            if (controller
                                                .currentTable
                                                .partialNotPaidProducts!
                                                .isEmpty) {
                                              print("içerdeyim");
                                              controller
                                                  .getCurrentTableAsObjectRemove(
                                                      controller
                                                          .currentTable.id!);
                                            }
                                          } else {
                                            controller
                                                .getCurrentTableAsObjectRemove(
                                                    controller
                                                        .currentTable.id!);
                                          }
                                          Get.offAllNamed(AppPages.INITIAL);
                                          // context.loaderOverlay.show();
                                        },
                                        child: Text("Ja"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 32),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
