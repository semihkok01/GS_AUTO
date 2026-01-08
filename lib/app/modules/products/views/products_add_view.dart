import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_order_basic/app/modules/home/controllers/home_controller.dart';
import 'package:pos_order_basic/app/routes/app_pages.dart';

class ProductsAddView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    late int tableNumber;
    late dynamic nominee;
    if (Get.arguments != null) {
      if (Get.arguments['table'] != null) {
        tableNumber = Get.arguments['table'];
      }
      if (Get.arguments['nominee'] != null) {
        nominee = Get.arguments['nominee'];
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Product'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
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
                              Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                'table': tableNumber,
                                'nominee': controller.buns
                              });
                            },
                            child: Text("Buns"),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromWidth(Get.width * 0.7)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                'table': tableNumber,
                                'nominee': controller.sandbuns
                              });
                            },
                            child: Text("Sandbuns"),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromWidth(Get.width * 0.7)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                'table': tableNumber,
                                'nominee': controller.bowls
                              });
                            },
                            child: Text("Bowls"),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromWidth(Get.width * 0.7)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                'table': tableNumber,
                                'nominee': controller.beilagen
                              });
                            },
                            child: Text("Beilagen"),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromWidth(Get.width * 0.7)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                'table': tableNumber,
                                'nominee': controller.hausgemacht
                              });
                            },
                            child: Text("H.G. Saucen"),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromWidth(Get.width * 0.7)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                'table': tableNumber,
                                'nominee': controller.sweets
                              });
                            },
                            child: Text("Sweets"),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromWidth(Get.width * 0.7)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                'table': tableNumber,
                                'nominee': controller.bunsupgrade
                              });
                            },
                            child: Text("Buns Upgrade"),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromWidth(Get.width * 0.7)),
                          ),
                        ],
                      ),
                    ));
              },
              child: Text(
                "E",
                style: TextStyle(color: Colors.black, fontSize: 30),
              )),
          TextButton(
              onPressed: () {
                Get.back();
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
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.softdrinks
                                });
                              },
                              child: Text("Softdrinks"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.safte
                                });
                              },
                              child: Text("Säfte&Schorlen"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.icetea
                                });
                              },
                              child: Text("ICE-Tea"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.hotdrinks
                                });
                              },
                              child: Text("Hotdrinks"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.wein
                                });
                              },
                              child: Text("Wein&Spritzig"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.fass
                                });
                              },
                              child: Text("Fassbier"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.fass
                                });
                              },
                              child: Text("Fassbier"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.flaschen
                                });
                              },
                              child: Text("Flaschenbier"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.cocktails
                                });
                              },
                              child: Text("Cocktails"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.mocktails
                                });
                              },
                              child: Text("Mocktails"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.highballs
                                });
                              },
                              child: Text("Highballs"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.mules
                                });
                              },
                              child: Text("Mules"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(Routes.PRODUCTSADD, arguments: {
                                  'table': tableNumber,
                                  'nominee': controller.shots
                                });
                              },
                              child: Text("Shoots"),
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width * 0.7)),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
              child: Text(
                "T",
                style: TextStyle(color: Colors.black, fontSize: 30),
              )),
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Produkte",
                  content: Container(
                    height: Get.size.height * 0.6,
                    width: Get.width * 0.8,
                    child: ListView.builder(
                      itemCount: controller.currentTable.products!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.amberAccent,
                          child: Text(
                            controller
                                    .currentTable.products![index].product!.name
                                    .toString() +
                                " - " +
                                controller.currentTable.products![index]
                                    .product!.price
                                    .toString() +
                                " €",
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      },
                    ),
                  ),
                  onConfirm: () {
                    Get.back();
                  },
                  textConfirm: "OK",
                );
              },
              icon: Icon(Icons.list)),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Obx(
                    () => SingleChildScrollView(
                      child: Column(children: [
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: nominee.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.size.width * .05),
                                child: ElevatedButton(
                                    onPressed: () {
                                      controller.addProduct2Table(
                                          tableNumber, nominee[index], 1);
                                    },
                                    child: Text(
                                        /*  nominee[index].category.toString() +
                                            "- " + */
                                        nominee[index].name.toString() +
                                            "- " +
                                            nominee[index].price.toString() +
                                            " €")),
                              );
                            },
                          ),
                        ),
                        Obx((() => Text(
                              controller.addedText.value,
                              style: TextStyle(fontSize: 20),
                            ))),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
