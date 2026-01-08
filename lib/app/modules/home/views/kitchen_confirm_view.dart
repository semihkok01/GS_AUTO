import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pos_order_basic/app/modules/home/controllers/home_controller.dart';
import 'package:pos_order_basic/app/modules/products/models/product_model.dart';
import 'package:pos_order_basic/app/routes/app_pages.dart';

class KitchenConfirmView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: LoaderOverlay(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Bist du sicher?'),
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
                        return Column(
                          children: [
                            Text(
                              "War Ausdruck Erfolgreich ?",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                  "Bitte wählen Sie -JA- wenn ausdruck erfolgreich war, ansonsten klicken Sie Nein für erneut Ausdruck."),
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
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                       
                                      },
                                      child: Text("Nein"),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        for (var i = 0;
                                            i <
                                                controller.currentTable
                                                    .products!.length;
                                            i++) {
                                          List<ProductModel> notWentToKitchen =
                                              controller.currentTable
                                                  .products![i].products!
                                                  .where((element) =>
                                                      element.wentToKitchen ==
                                                          false ||
                                                      element.wentToKitchen ==
                                                          null)
                                                  .toList();
                                          for (var j = 0;
                                              j < notWentToKitchen.length;
                                              j++) {
                                            notWentToKitchen[j].wentToKitchen =
                                                true;
                                            controller.update();
                                          }
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
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 40,
                              width: Size.infinite.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.offAllNamed(AppPages.INITIAL);
                                      },
                                      child: Text("Startseite"),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
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
