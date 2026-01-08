import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_order_basic/app/modules/home/controllers/home_controller.dart';
import 'package:pos_order_basic/app/routes/app_pages.dart';

class TablesView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tische'),
        actions: [],
      ),
      body: SafeArea(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  GetBuilder<HomeController>(
                    initState: (_) {},
                    builder: (controller) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.tables.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.size.width * .05,
                                        vertical: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Get.toNamed(Routes.PRODUCTS,
                                                    arguments: {
                                                      "table": controller
                                                          .tables[index].id,
                                                    });
                                              },
                                              child: RichText(
                                                text: TextSpan(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge
                                                      ?.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                  text: controller
                                                      .tables[index].name
                                                      .toString(),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: (controller
                                                              .tables[index]
                                                              .products!
                                                              .isNotEmpty
                                                          ? " (€ " +
                                                              controller
                                                                  .tables[index]
                                                                  .total!
                                                                  .toStringAsFixed(
                                                                      2) +
                                                              ")"
                                                          : ""),
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
