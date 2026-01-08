import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_order_basic/app/modules/home/controllers/home_controller.dart';
import 'package:pos_order_basic/app/routes/app_pages.dart';

class BillsView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rechnungen'),
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
                    initState: (_) {
                      controller.calculateTotalBills();
                    },
                    builder: (controller) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                            text: "Gesamt: ",
                            children: <TextSpan>[
                              TextSpan(
                                text: ("€ " +
                                    controller.totalBill.toStringAsFixed(2)),
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 12),
                              ),
                            ],
                          ),
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
                            Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.bills.length,
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
                                                Get.toNamed(Routes.BILL,
                                                    arguments: {
                                                      "table": controller
                                                          .bills[index].id,
                                                    });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                                    text: controller
                                                        .bills[index].name
                                                        .toString(),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: (controller
                                                                .bills[index]
                                                                .products!
                                                                .isNotEmpty
                                                            ? " (€ " +
                                                                ((controller.bills[index].partialPaidConfirmedProducts !=
                                                                            null &&
                                                                        controller.bills[index].partialPaidConfirmedProducts !=
                                                                            [])
                                                                    ? controller
                                                                        .bills[
                                                                            index]
                                                                        .totalPaid!
                                                                        .toStringAsFixed(
                                                                            2)
                                                                    : controller
                                                                        .bills[
                                                                            index]
                                                                        .total!
                                                                        .toStringAsFixed(
                                                                            2)) +
                                                                ")"
                                                            : ""),
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
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
