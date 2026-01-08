import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CategoriesView'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Please add the Info for new Product',
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: controller.categori,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Add a Categorie"),
              ),
              SizedBox(
                height: 30,
              ),

              //You can make here a List Dropdown , the Staff will add first the categories and the Products
              Text(
                'Please select the Categorie for this Product',
                style: TextStyle(fontSize: 20),
              ),

              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(20),
                child: DropdownButtonHideUnderline(
                  child: GFDropdown(
                    padding: const EdgeInsets.all(15),
                    borderRadius: BorderRadius.circular(5),
                    border: const BorderSide(color: Colors.black12, width: 1),
                    dropdownButtonColor: Colors.white,
                    value: controller.catvalue,
                    onChanged: (newValue) {
                      controller.catvalue = newValue;
                    },
                    items: [
                      'Eat',
                      'Meat',
                      'Drink',
                    ]
                        .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Text("Please give the Name for this Product"),
              TextField(
                controller: controller.name,
              ),

              SizedBox(
                height: 30,
              ),
              Text("Please give the Price for this Product"),
              TextField(
                controller: controller.price,
              ),

              ElevatedButton(
                onPressed: () {
                  controller.saveProduct(
                      controller.categori.text,
                      controller.name.text,
                      double.parse(controller.price.text));
                },
                child: Text("Add Product"),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
