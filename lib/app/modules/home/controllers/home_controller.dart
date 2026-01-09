import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:pos_order_basic/app/modules/products/models/extra_model.dart';
import 'package:pos_order_basic/app/modules/products/models/product_list_model.dart';
import 'package:pos_order_basic/app/modules/products/models/product_model.dart';
import 'package:pos_order_basic/app/modules/products/models/returned_product_list_model.dart';
import 'package:pos_order_basic/app/modules/tables/models/table.dart';
import 'package:intl/intl.dart';


import 'package:pos_order_basic/app/routes/app_pages.dart';


class HomeController extends GetxController {
  GetStorage depo = GetStorage();

  var total = 0.00.obs;
  List<TableModel> tables = [];
  TableModel zReportTable = TableModel(
      id: 0,
      name: "Z-Bericht",
      products: [],
      removedProducts: [],
      returnedProducts: [],
      partialPaidProducts: [],
      partialNotPaidProducts: [],
      partialPaidConfirmedProducts: [],
      total: 0);
  List<String?> extraCategories = [];
  TableModel currentTable = TableModel();
  List<TableModel> bills = [];
  TableModel currentBill = TableModel();
  int billPrinted = 0;
  var totalBill = 0.00;

  TextEditingController customProductNameController = TextEditingController();
  TextEditingController customProductPriceController =
      TextEditingController(text: "0.00");
  TextEditingController customNoteController = TextEditingController();

  var yazici = "".obs;

  RxList softdrinks = [].obs;
  RxList safte = [].obs;
  RxList icetea = [].obs;
  RxList hotdrinks = [].obs;
  RxList wein = [].obs;
  RxList fass = [].obs;
  RxList flaschen = [].obs;
  RxList cocktails = [].obs;
  RxList mocktails = [].obs;
  RxList highballs = [].obs;
  RxList mules = [].obs;
  RxList shots = [].obs;
  RxList buns = [].obs;
  RxList sandbuns = [].obs;
  RxList hausgemacht = [].obs;
  RxList beilagen = [].obs;
  RxList bowls = [].obs;
  RxList sweets = [].obs;
  RxList bunsupgrade = [].obs;

  List<ExtraModel> extras = [];
  var addedText = "".obs;

  static const String _menuUrl = "https://mobil-dershane.com/menu/menu.json";
  Future<Map<String, dynamic>?>? _menuFetchFuture;

  Future<Map<String, dynamic>?> _fetchMenu() async {
    _menuFetchFuture ??= _loadMenu();
    final menu = await _menuFetchFuture;
    _menuFetchFuture = null;
    return menu;
  }

  Future<Map<String, dynamic>?> _loadMenu() async {
    try {
      final response = await Dio().get(_menuUrl);
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }
      if (data is Map) {
        return Map<String, dynamic>.from(data);
      }
      if (data is String) {
        final decoded = jsonDecode(data);
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      }
    } catch (_) {}
    return null;
  }

  int? _readInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return null;
  }

  double? _readDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    return null;
  }

  List<ProductModel> _mapCategory(dynamic items, String categoryName) {
    if (items is! List) {
      return [];
    }
    return items
        .whereType<Map>()
        .map((item) => ProductModel(
              id: _readInt(item["id"]),
              category: categoryName,
              name: item["name"] as String?,
              price: _readDouble(item["price"]),
              hasExtra: item["hasExtra"] as bool?,
              printerId: _readInt(item["printerId"]),
            ))
        .toList();
  }

  bool _applyMenu(Map<String, dynamic> menu) {
    final categoriesRaw = menu["categories"];
    if (categoriesRaw is! Map) {
      return false;
    }
    final categories = Map<String, dynamic>.from(categoriesRaw);
    final categoryTargets = <String, RxList>{
      "Buns Upgrades": bunsupgrade,
      "Softdrinks": softdrinks,
      "Saefte und Schorlen": safte,
      "Iced Tea Und Refresher": icetea,
      "Hot Drinks": hotdrinks,
      "Wein und Spritzig": wein,
      "Fassbier": fass,
      "Flaschenbier": flaschen,
      "Cocktails": cocktails,
      "Mocktails": mocktails,
      "Highballs": highballs,
      "Mules": mules,
      "Shots": shots,
      "Buns": buns,
      "Sandbuns": sandbuns,
      "Hausgemachte Saucen": hausgemacht,
      "Beilagen": beilagen,
      "Bowls": bowls,
      "Sweets": sweets,
    };
    categoryTargets.forEach((categoryName, targetList) {
      targetList.value = [];
      targetList.addAll(_mapCategory(categories[categoryName], categoryName));
    });

    extras = [];
    extraCategories = [
      "Ekstra",
    ];
    extras.addAll([]);
    update();
    print("Menu loaded from URL: $_menuUrl");
    return true;
  }

  Future<void> initProducts() async {
    final menu = await _fetchMenu();
    if (menu != null && _applyMenu(menu)) {
      return;
    }

  bunsupgrade.value = [];
bunsupgrade.addAll([
  ProductModel(id: 200, category: "Buns Upgrades", name: "Süßkartoffel-Pommes", price: 2.5, hasExtra: false, printerId: 0),
  ProductModel(id: 201, category: "Buns Upgrades", name: "Crispy Fried Chicken", price: 2.5, hasExtra: false, printerId: 0),
  ProductModel(id: 202, category: "Buns Upgrades", name: "Extra Käse", price: 1.0, hasExtra: false, printerId: 0),
  ProductModel(id: 203, category: "Buns Upgrades", name: "Extra Beef Patty", price: 4.5, hasExtra: false, printerId: 0),
  ProductModel(id: 204, category: "Buns Upgrades", name: "Extra Beyond Patty", price: 5.5, hasExtra: false, printerId: 0),
  ProductModel(id: 205, category: "Buns Upgrades", name: "Burrata", price: 2.9, hasExtra: false, printerId: 0),
  ProductModel(id: 206, category: "Buns Upgrades", name: "Avocado", price: 2.5, hasExtra: false, printerId: 0),
  ProductModel(id: 207, category: "Buns Upgrades", name: "Jalapeños", price: 0.5, hasExtra: false, printerId: 0),
  ProductModel(id: 208, category: "Buns Upgrades", name: "Karamellisierte Zwiebeln", price: 0.8, hasExtra: false, printerId: 0),
  ProductModel(id: 209, category: "Buns Upgrades", name: "Sucuk", price: 4.5, hasExtra: false, printerId: 0),
  ProductModel(id: 5001, category: "Buns Upgrades", name: "Mit Spiegelei", price: 2.5, hasExtra: false, printerId: 0),
  ProductModel(id: 5002, category: "Buns Upgrades", name: "Ohne Pommes", price: -2, hasExtra: false, printerId: 0),
]);


    softdrinks.value = [];
   softdrinks.addAll([
  ProductModel(name: "Red Bull Energy Drink", price: 3.5),
  ProductModel(name: "Red Bull Sugarfree", price: 3.5),
  ProductModel(name: "St. Michaelis Still / Laut", price: 3.0),
  ProductModel(name: "St. Michaelis", price: 6.8),
  ProductModel(name: "Fritz-Kola", price: 3.5),
  ProductModel(name: "Fritz-Kola Light", price: 3.5),
  ProductModel(name: "Fritz-Kola Super Zero", price: 3.5),
  ProductModel(name: "Fritz-Kola Orange", price: 3.5),
  ProductModel(name: "Fritz-Spritz Bio-Apfel", price: 3.5),
  ProductModel(name: "Fritz-Kola Zitrone", price: 3.5),
  ProductModel(name: "Fritz-Kola Melone", price: 3.5),
  ProductModel(name: "Fritz-Kola Rhabarber", price: 3.5),
  ProductModel(name: "Fritz-Kola Misch Masch", price: 3.5),
  ProductModel(name: "Fritz-Limo Ingwer Limette", price: 3.5),
  ProductModel(name: "Schweppes Tonic Water", price: 3.0),
  ProductModel(name: "Schweppes Ginger Beer", price: 3.0),
  ProductModel(name: "Schweppes White Berry", price: 3.0),
  ProductModel(name: "Schweppes Ginger Ale", price: 3.0),
  ProductModel(name: "Schweppes Bitter Lemon", price: 3.0),

]);
safte.value = [];
safte.addAll([
  ProductModel(
    id: 3005,
    category: "Saefte und Schorlen",
    name: "Frischer O-Saft",
    price: 4.8,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 3006,
    category: "Saefte und Schorlen",
    name: "Maracujasaft",
    price: 4.2,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 3007,
    category: "Saefte und Schorlen",
    name: "Cranberrysaft",
    price: 4.2,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 3009,
    category: "Saefte und Schorlen",
    name: "Ananassaft",
    price: 4.2,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 3010,
    category: "Saefte und Schorlen",
    name: "Orangensaft",
    price: 4.2,
    hasExtra: false,
    printerId: 0,
  ),
]);



  icetea.value = [];
icetea.addAll([
  ProductModel(
    id: 23,
    category: "Iced Tea Und Refresher",
    name: "Fruit Iced Tea",
    price: 5.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 24,
    category: "Iced Tea Und Refresher",
    name: "Peach Iced Tea",
    price: 5.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 25,
    category: "Iced Tea Und Refresher",
    name: "Green Mint",
    price: 5.8,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 26,
    category: "Iced Tea Und Refresher",
    name: "Detox",
    price: 4.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 27,
    category: "Iced Tea Und Refresher",
    name: "Cörcil",
    price: 4.0,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 28,
    category: "Iced Tea Und Refresher",
    name: "Berry Lush",
    price: 5.5,
    hasExtra: false,
    printerId: 0,
  ),
]);

 hotdrinks.value = [];
hotdrinks.addAll([
  ProductModel(id: 29, category: "Hot Drinks", name: "Americano", price: 3.2, hasExtra: false, printerId: 0),
  ProductModel(id: 30, category: "Hot Drinks", name: "Espresso", price: 2.0, hasExtra: false, printerId: 0),
  ProductModel(id: 31, category: "Hot Drinks", name: "Espresso Doppel", price: 2.9, hasExtra: false, printerId: 0),
  ProductModel(id: 32, category: "Hot Drinks", name: "Espresso Macchiato", price: 2.4, hasExtra: false, printerId: 0),
  ProductModel(id: 33, category: "Hot Drinks", name: "Cappuccino", price: 4.2, hasExtra: false, printerId: 0),
  ProductModel(id: 34, category: "Hot Drinks", name: "Latte Macchiato", price: 4.5, hasExtra: false, printerId: 0),
  ProductModel(id: 35, category: "Hot Drinks", name: "Matcha Latte", price: 4.9, hasExtra: false, printerId: 0),
  ProductModel(id: 36, category: "Hot Drinks", name: "Heisse Schokolade", price: 3.2, hasExtra: false, printerId: 0),
  ProductModel(id: 37, category: "Hot Drinks", name: "Salep", price: 2.9, hasExtra: false, printerId: 0),
  ProductModel(id: 38, category: "Hot Drinks", name: "Iced Latte", price: 4.9, hasExtra: true, printerId: 0),
  ProductModel(id: 39, category: "Hot Drinks", name: "Iced Matcha Latte", price: 5.5, hasExtra: true, printerId: 0),
  ProductModel(id: 3011, category: "Hot Drinks", name: "Sirup (Karamell, Vanille & Cocosflavor)", price: 0.3, hasExtra: false, printerId: 0),
  ProductModel(id: 40, category: "Hot Drinks", name: "Frischer Minztee", price: 3.5, hasExtra: false, printerId: 0),
  ProductModel(id: 41, category: "Hot Drinks", name: "Frischer Zitronentee", price: 3.2, hasExtra: false, printerId: 0),
  ProductModel(id: 42, category: "Hot Drinks", name: "Frischer Ingwertee", price: 3.5, hasExtra: false, printerId: 0),
  ProductModel(id: 43, category: "Hot Drinks", name: "Teeauswahl", price: 2.8, hasExtra: false, printerId: 0),
]);

  wein.value = [];
wein.addAll([
  ProductModel(id: 44, category: "Wein und Spritzig", name: "Rosé (0,2 l)", price: 5.5, hasExtra: false, printerId: 0),
  ProductModel(id: 45, category: "Wein und Spritzig", name: "Rosé (1,0 l)", price: 18.9, hasExtra: false, printerId: 0),
  ProductModel(id: 46, category: "Wein und Spritzig", name: "Merlot (0,2 l)", price: 5.5, hasExtra: false, printerId: 0),
  ProductModel(id: 47, category: "Wein und Spritzig", name: "Merlot (1,0 l)", price: 18.9, hasExtra: false, printerId: 0),
  ProductModel(id: 48, category: "Wein und Spritzig", name: "Grauer Burgunder (0,2 l)", price: 5.5, hasExtra: false, printerId: 0),
  ProductModel(id: 49, category: "Wein und Spritzig", name: "Grauer Burgunder (1,0 l)", price: 18.9, hasExtra: false, printerId: 0),
  ProductModel(id: 50, category: "Wein und Spritzig", name: "Weisswein Schorle Süß (0,2 l)", price: 4.5, hasExtra: false, printerId: 0),
  ProductModel(id: 51, category: "Wein und Spritzig", name: "Aperol Spritz", price: 7.5, hasExtra: false, printerId: 0),
  ProductModel(id: 52, category: "Wein und Spritzig", name: "Lillet Purple Berry", price: 7.5, hasExtra: false, printerId: 0),
  ProductModel(id: 53, category: "Wein und Spritzig", name: "Gin Pink Spritz", price: 7.9, hasExtra: false, printerId: 0),
  ProductModel(id: 55, category: "Wein und Spritzig", name: "Black Orange Spritz", price: 8.0, hasExtra: false, printerId: 0),
  ProductModel(id: 56, category: "Wein und Spritzig", name: "Red Gin Melon", price: 8.5, hasExtra: false, printerId: 0),
]);

  fass.value = [];
fass.addAll([
  ProductModel(
    id: 57,
    category: "Fassbier",
    name: "Beck s (0,4 l)",
    price: 4.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 58,
    category: "Fassbier",
    name: "Weizen (0,5 l)",
    price: 4.8,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 59,
    category: "Fassbier",
    name: "Alster (0,4 l)",
    price: 4.5,
    hasExtra: false,
    printerId: 0,
  ),
]);

   flaschen.value = [];
flaschen.addAll([
  ProductModel(
    id: 60,
    category: "Flaschenbier",
    name: "Beck s (0,33 l)",
    price: 3.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 61,
    category: "Flaschenbier",
    name: "Beck s Alkoholfrei (0,33 l)",
    price: 3.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 62,
    category: "Flaschenbier",
    name: "Pilsner Urquell (0,33 l)",
    price: 3.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 63,
    category: "Flaschenbier",
    name: "Corona (0,33 l)",
    price: 3.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 64,
    category: "Flaschenbier",
    name: "Heineken (0,25 l)",
    price: 3.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 65,
    category: "Flaschenbier",
    name: "Weizen Alkoholfrei (0,5 l)",
    price: 4.8,
    hasExtra: false,
    printerId: 0,
  ),
]);

cocktails.value = [];
cocktails.addAll([
  ProductModel(
    id: 66,
    category: "Cocktails",
    name: "Gin Basil",
    price: 8.9,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 67,
    category: "Cocktails",
    name: "Espresso Martini",
    price: 8.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 68,
    category: "Cocktails",
    name: "Mallow Me Up",
    price: 8.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 69,
    category: "Cocktails",
    name: "Yellow Tiki",
    price: 8.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 70,
    category: "Cocktails",
    name: "Cosmo",
    price: 8.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 71,
    category: "Cocktails",
    name: "Cloud",
    price: 8.5,
    hasExtra: false,
    printerId: 0,
  ),
]);


    mocktails.value = [];
mocktails.addAll([
  ProductModel(
    id: 72,
    category: "Mocktails",
    name: "Sweet Virgin",
    price: 7.0,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 73,
    category: "Mocktails",
    name: "Solero",
    price: 7.0,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 74,
    category: "Mocktails",
    name: "Pina Princess",
    price: 7.0,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 75,
    category: "Mocktails",
    name: "Virgin Mojito",
    price: 7.0,
    hasExtra: false,
    printerId: 0,
  ),
]);
highballs.value = [];
highballs.addAll([
  ProductModel(id: 76, category: "Highballs", name: "Jack Daniel's Cola", price: 8.0, hasExtra: false, printerId: 0),
  ProductModel(id: 77, category: "Highballs", name: "Absolut Vodka Red Bull", price: 8.0, hasExtra: false, printerId: 0),
  ProductModel(id: 78, category: "Highballs", name: "Absolut Vodka Purple Berry", price: 8.0, hasExtra: false, printerId: 0),
  ProductModel(id: 79, category: "Highballs", name: "Bombay Sapphire Tonic", price: 8.0, hasExtra: false, printerId: 0),
  ProductModel(id: 80, category: "Highballs", name: "Hendrick s Tonic", price: 8.5, hasExtra: false, printerId: 0),
  ProductModel(id: 81, category: "Highballs", name: "Havana Club Cola", price: 8.0, hasExtra: false, printerId: 0),
  ProductModel(id: 82, category: "Highballs", name: "Mojito", price: 8.5, hasExtra: false, printerId: 0),
  ProductModel(id: 83, category: "Highballs", name: "Caipirinha", price: 8.5, hasExtra: false, printerId: 0),
  ProductModel(id: 84, category: "Highballs", name: "Sex on the Beach", price: 8.5, hasExtra: false, printerId: 0),
  ProductModel(id: 85, category: "Highballs", name: "Prince", price: 8.5, hasExtra: false, printerId: 0),
  ProductModel(id: 86, category: "Highballs", name: "Pina Colada", price: 8.5, hasExtra: false, printerId: 0),
  ProductModel(id: 87, category: "Highballs", name: "Long Island Iced Tea", price: 9.0, hasExtra: false, printerId: 0),
]);

   mules.value = [];
mules.addAll([
  ProductModel(
    id: 88,
    category: "Mules",
    name: "Moscow Mule",
    price: 8.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 89,
    category: "Mules",
    name: "London Mule",
    price: 8.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 90,
    category: "Mules",
    name: "Maui Mule",
    price: 8.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 91,
    category: "Mules",
    name: "Frisco Mule",
    price: 8.5,
    hasExtra: false,
    printerId: 0,
  ),
]);

    shots.value = [];
shots.addAll([
  ProductModel(
    id: 92,
    category: "Shots",
    name: "Tequila Silber",
    price: 2.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 93,
    category: "Shots",
    name: "Jägermeister",
    price: 2.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 94,
    category: "Shots",
    name: "Sambuca",
    price: 2.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 95,
    category: "Shots",
    name: "Frangelico",
    price: 2.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 96,
    category: "Shots",
    name: "Berliner Luft",
    price: 2.5,
    hasExtra: false,
    printerId: 0,
  ),
]);

   buns.value = [];
buns.addAll([
  ProductModel(id: 97, category: "Buns", name: "Cheeseburger Bun", price: 13.5, hasExtra: false, printerId: 0),
  ProductModel(id: 98, category: "Buns", name: "BBQ Bun", price: 13.9, hasExtra: false, printerId: 0),
  ProductModel(id: 99, category: "Buns", name: "Crispy Chicken Bun", price: 13.9, hasExtra: false, printerId: 0),
  ProductModel(id: 100, category: "Buns", name: "Ceaser Chicken Bun", price: 14.5, hasExtra: false, printerId: 0),
  ProductModel(id: 101, category: "Buns", name: "Korean Chicken Bun", price: 14.9, hasExtra: false, printerId: 0),
  ProductModel(id: 102, category: "Buns", name: "Veggi Beyond Meat Bun", price: 14.9, hasExtra: false, printerId: 0),
  ProductModel(id: 103, category: "Buns", name: "Halloumi Bun", price: 12.9, hasExtra: false, printerId: 0),
  ProductModel(id: 104, category: "Buns", name: "Veggie Tofu Bun", price: 14.9, hasExtra: false, printerId: 0),
  ProductModel(id: 3000, category: "Buns", name: "Krabs", price: 14.5, hasExtra: false, printerId: 0),
  ProductModel(id: 3005, category: "Buns", name: "Tofu Crispy Bun", price: 14.9, hasExtra: false, printerId: 0),
    ProductModel(id: 3006, category: "Buns", name: "Tofu Korean Bun", price: 15.9, hasExtra: false, printerId: 0),
      ProductModel(id: 3007, category: "Buns", name: "Tofu Ceaser Bun", price: 15.5, hasExtra: false, printerId: 0),
      ProductModel(id: 3008, category: "Buns", name: "Vegan BBQ Bun", price: 15.9, hasExtra: false, printerId: 0),
]);


  sandbuns.value = [];
sandbuns.addAll([
  ProductModel(
    id: 105,
    category: "Sandbuns",
    name: "Little Nene",
    price: 9.9,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 106,
    category: "Sandbuns",
    name: "Holy Cow",
    price: 13.9,
    hasExtra: false,
    printerId: 0,
  ),
]);


   bowls.value = [];
bowls.addAll([
  ProductModel(
    id: 108,
    category: "Bowls",
    name: "Burrata Bowl",
    price: 12.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 109,
    category: "Bowls",
    name: "Chicken Bowl",
    price: 12.5,
    hasExtra: false,
    printerId: 0,
  ),
  ProductModel(
    id: 110,
    category: "Bowls",
    name: "Tofu Bowl",
    price: 12.5,
    hasExtra: false,
    printerId: 0,
  ),
]);

   hausgemacht.value = [];
hausgemacht.addAll([
  ProductModel(id: 111, category: "Hausgemachte Saucen", name: "Spicy Maracuja", price: 1.5, hasExtra: false, printerId: 0),
  ProductModel(id: 112, category: "Hausgemachte Saucen", name: "Bun s Burger Sauce", price: 1.0, hasExtra: false, printerId: 0),
  ProductModel(id: 113, category: "Hausgemachte Saucen", name: "Honig-Senf", price: 1.0, hasExtra: false, printerId: 0),
  ProductModel(id: 114, category: "Hausgemachte Saucen", name: "Trüffel Mayo", price: 2.0, hasExtra: false, printerId: 0),
  ProductModel(id: 115, category: "Hausgemachte Saucen", name: "Ketchup/Mayo", price: 1.0, hasExtra: false, printerId: 0),
  ProductModel(id: 116, category: "Hausgemachte Saucen", name: "Aioli", price: 1.5, hasExtra: false, printerId: 0),
  ProductModel(id: 117, category: "Hausgemachte Saucen", name: "Chili Cheese", price: 2.0, hasExtra: false, printerId: 0),
]);

beilagen.value = [];
beilagen.addAll([
  ProductModel(id: 117, category: "Beilagen", name: "Pommes", price: 4.5, hasExtra: false, printerId: 0),
  ProductModel(id: 118, category: "Beilagen", name: "Süßkartoffeln", price: 6.5, hasExtra: false, printerId: 0),
  ProductModel(id: 119, category: "Beilagen", name: "Coleslaw", price: 4.0, hasExtra: false, printerId: 0),
  ProductModel(id: 120, category: "Beilagen", name: "Krabs (4 Stück)", price: 6.9, hasExtra: false, printerId: 0),
  ProductModel(id: 121, category: "Beilagen", name: "Crispy Fried Chicken (2 Stück)", price: 5.5, hasExtra: false, printerId: 0),
  ProductModel(id: 122, category: "Beilagen", name: "Korean Fried Chicken (2 Stück)", price: 6.5, hasExtra: false, printerId: 0),
]);


    sweets.value = [];
    sweets.addAll([
      /*  ProductModel(
        id: 121,
        category: "Sweets",
        name: "French Bun Mit Zimt und Zucker",
        price: 5.9,
        hasExtra: false,
        printerId: 0,
      ),
      ProductModel(
        id: 122,
        category: "Sweets",
        name: "Ahornsirup",
        price: 1.2,
        hasExtra: false,
        printerId: 0,
      ),
      ProductModel(
        id: 123,
        category: "Sweets",
        name: "Beerenkompott",
        price: 1.2,
        hasExtra: false,
        printerId: 0,
      ),
      ProductModel(
        id: 124,
        category: "Sweets",
        name: "Mascarpone Creme",
        price: 1.5,
        hasExtra: false,
        printerId: 0,
      ), */
      ProductModel(
        id: 125,
        category: "Sweets",
        name: "Cake Pot Oreo Cheescake",
        price: 6.5,
        hasExtra: false,
        printerId: 0,
      ),
    ]);

    extras = [];
    extraCategories = [
      "Ekstra",
    ];
    extras.addAll([]);
    update();
  }

  void getCurrentTable(int id) {
    TableModel table = tables.firstWhere((element) => element.id == id);
    currentTable = table;
  }

  void getCurrentBill(int id) {
    TableModel table = bills.firstWhere((element) => element.id == id);
    currentBill = table;
  }

  void getCurrentTableAsObjectRemove(int id) {
    TableModel table = tables.firstWhere((element) => element.id == id);
    table.products = [];
    table.partialNotPaidProducts = [];
    table.partialPaidProducts = [];
    table.partialPaidProducts = [];
    table.total = 0.0;
    table.totalPaid = 0.0;
    table.totalNotPaid = 0.0;
    table.totalWillPay = 0.0;
    table.removedProducts = [];
    table.returnedProducts = [];
    update();
    currentTable = TableModel();
    var tablesEncoded = jsonEncode(tables);
    depo.write("tables", tablesEncoded);
    update();
  }

  void calculateTotal() {
    tables.forEach((element) {
      element.total = 0.00;
      element.totalPaid = 0.00;
      element.totalNotPaid = 0.00;
      element.totalWillPay = 0.00;
      element.products!.forEach((element0) {
        if (element0.product!.price != null) {
          if (element0.total == null) {
            element0.total = element0.product!.price! * element0.count!;
          }
          element.total = element.total! + element0.total!;
        }
      });

      if (element.partialPaidConfirmedProducts != null) {
        element.partialPaidConfirmedProducts!.forEach((element0) {
          if (element0.product!.price != null) {
            if (element0.total == null) {
              element0.total = element0.product!.price! * element0.count!;
            }
            element.totalPaid = element.totalPaid! + element0.total!;
          }
        });
      }

      if (element.partialNotPaidProducts != null) {
        element.partialNotPaidProducts!.forEach((element0) {
          if (element0.product!.price != null) {
            if (element0.total == null) {
              element0.total = element0.product!.price! * element0.count!;
            }
            element.totalNotPaid = element.totalNotPaid! + element0.total!;
          }
        });
      }

      if (element.partialPaidProducts != null) {
        element.partialPaidProducts!.forEach((element0) {
          if (element0.product!.price != null) {
            if (element0.total == null) {
              element0.total = element0.product!.price! * element0.count!;
            }
            element.totalWillPay = element.totalWillPay! + element0.total!;
          }
        });
      }
    });
    update();
  }

  void addProduct2Table(int? tableId, ProductModel? product, int? oid) {
    int lastIndex = 0;
    if (tableId != null) {
      TableModel table = tables.firstWhere((element) => element.id == tableId);
      if (table.products!
          .where((element) => element.product!.id == product!.id)
          .isNotEmpty) {
        ProductListModel productListObj = table.products!
            .firstWhere((element) => element.product!.id == product!.id);
        ProductListModel productListObjReplicate =
            ProductListModel.fromJson(productListObj.toJson());
        table.products!.remove(productListObj);
        productListObjReplicate.count = productListObjReplicate.count! + 1;
        productListObjReplicate.total = productListObjReplicate.count! *
            productListObjReplicate.product!.price!;
        productListObjReplicate.products!.add(product!);
        lastIndex = productListObjReplicate.products!
            .indexOf(productListObjReplicate.products!.last);
        table.products!.add(productListObjReplicate);

        // Add new product to not paid if already have
        if ((table.partialNotPaidProducts != null ||
                table.partialNotPaidProducts != []) &&
            table.partialNotPaidProducts!
                .where((element) => element.product!.id == product.id)
                .isNotEmpty) {
          ProductListModel productListObj = table.partialNotPaidProducts!
              .firstWhere((element) => element.product!.id == product.id);
          ProductListModel productListObjReplicate =
              ProductListModel.fromJson(productListObj.toJson());
          table.partialNotPaidProducts!.remove(productListObj);
          productListObjReplicate.count = productListObjReplicate.count! + 1;
          productListObjReplicate.total = productListObjReplicate.count! *
              productListObjReplicate.product!.price!;
          productListObjReplicate.products!.add(product);
          lastIndex = productListObjReplicate.products!
              .indexOf(productListObjReplicate.products!.last);
          table.partialNotPaidProducts!.add(productListObjReplicate);
        }
      } else {
        ProductListModel productListObj0 = ProductListModel(
            products: [],
            product: product,
            count: 1,
            total: (product!.price! * 1));
        productListObj0.products!.add(product);
        table.products!.add(productListObj0);

        if (table.partialNotPaidProducts == [] ||
            table.partialNotPaidProducts == null) {
          table.partialNotPaidProducts = [];
        }
        table.partialNotPaidProducts!.add(productListObj0);

        lastIndex =
            productListObj0.products!.indexOf(productListObj0.products!.last);
      }

      currentTable = table;
      update();

      // Redirect to extras
      if (product.hasExtra == true) {
        TableModel table =
            tables.firstWhere((element) => element.id == tableId);
        int productListObj = table.products!
            .indexWhere((element) => element.product!.id == product.id);
        if (oid != null && oid == 1) {
          Get.offNamed(Routes.PRODUCTSEXTRA, arguments: {
            "table": tableId,
            "productList": productListObj,
            "product": lastIndex
          });
        } else {
          Get.toNamed(Routes.PRODUCTSEXTRA, arguments: {
            "table": tableId,
            "productList": productListObj,
            "product": lastIndex
          });
        }
      } else {
        addedText.value = "Product(" + product.name! + ") hinzugefügt";
        Duration duration = Duration(milliseconds: 2000);
        Timer(duration, () {
          addedText.value = "";
        });
        //Get.back();
      }

      print("Table: ${jsonEncode(table.partialNotPaidProducts)}");

      update();
      calculateTotal();
      var tablesEncoded = jsonEncode(tables);
      depo.write("tables", tablesEncoded);
      update();
    }
  }

  void removeProduct2Table(int? id, ProductModel? product) {
    if (id != null) {
      TableModel table = tables.firstWhere((element) => element.id == id);
      ProductListModel productListObj = table.products!
          .firstWhere((element) => element.product!.id == product!.id);
      if (productListObj.count! == 1) {
        table.products!.remove(productListObj);
        table.removedProducts!.add(productListObj);
      } else if (productListObj.count! > 1) {
        productListObj.products!.remove(product);
        productListObj.count = productListObj.count! - 1;
        productListObj.total =
            productListObj.product!.price! * productListObj.count!;
        //table.products!.add(productListObj);

        try {
          ProductListModel removedProductListObj = table.removedProducts!
              .firstWhere((element) => element.product!.id == product!.id);
          // ignore: unnecessary_null_comparison
          if (removedProductListObj != null) {
            ProductListModel removedProductListObj00 = removedProductListObj
                .copyWith(count: 1, total: product!.price!);
            table.removedProducts!.add(removedProductListObj00);
          }
        } catch (e) {
          print("Error: $e");
        }
      }
      var tablesEncoded = jsonEncode(tables);
      depo.write("tables", tablesEncoded);
      calculateTotal();
      update();
      /*  Get.snackbar("Produkt gelöscht", "Produkt wurde gelöscht",
          snackPosition: SnackPosition.BOTTOM);
 */

      removeProduct2ZReportTable(product);
    }
  }

  void initBillCount() {
    if (depo.read("billPrinted") != null) {
      billPrinted = depo.read("billPrinted");
      update();
    }
  }

  void calculateTotalBills() {
    totalBill = 0.00;
    bills.forEach((element) {
      if (element.partialPaidConfirmedProducts != null &&
          element.partialPaidConfirmedProducts != [] &&
          element.totalPaid != null &&
          element.totalPaid != 0) {
        totalBill = totalBill + element.totalPaid!;
      } else {
        element.products!.forEach((element0) {
          if (element0.products!.isNotEmpty) {
            totalBill = totalBill + element0.total!;
            update();
          }
        });
      }
    });
    update();
  }

  void initTables() {
    if (depo.read("tables") == null) {
      for (int i = 0; i < 100; i++) {
        tables.add(TableModel(
            id: i,
            name: 'Tisch ${i + 1}',
            products: [],
            removedProducts: [],
            partialNotPaidProducts: [],
            partialPaidProducts: [],
            partialPaidConfirmedProducts: [],
            total: 0.00,
            totalPaid: 0.00,
            totalNotPaid: 0.00,
            totalWillPay: 0.00));
      }
    } else {
      var tempList = jsonDecode(depo.read("tables"));

      if (tempList != null) {
        tempList.forEach((value) {
          if (value.runtimeType != TableModel) {
            TableModel table = TableModel(
                id: value["id"],
                name: value["name"],
                products: [],
                removedProducts: [],
                partialPaidProducts: [],
                partialNotPaidProducts: [],
                partialPaidConfirmedProducts: [],
                total: value["total"],
                totalPaid: value["totalPaid"],
                totalNotPaid: value["totalNotPaid"],
                totalWillPay: value["totalWillPay"],
                note: value["note"]);
            value["products"].forEach(
              (element) {
                ProductModel product = ProductModel(
                    id: element["product"]["id"],
                    category: element["product"]["category"],
                    name: element["product"]["name"],
                    price: element["product"]["price"],
                    extras: [],
                    hasExtra: element["product"]["hasExtra"],
                    returned: element["product"]["returned"],
                    wentToKitchen: element["product"]["wentToKitchen"],
                    printerId: element["product"]["printerId"]);

                if (element["product"]["extras"] != null) {
                  element["product"]["extras"].forEach((element) {
                    final extraObj = ExtraModel(
                        category: element["category"],
                        content: element["content"],
                        status: element["status"],
                        price: element["price"]);
                    product.extras!.add(extraObj);
                  });
                }

                ProductListModel productListObj00 = ProductListModel(
                    products: [],
                    product: product,
                    count: (element["count"] != null) ? element["count"] : 1,
                    total:
                        (element["total"] != null) ? element["total"] : 0.00);

                element["products"].forEach((element000) {
                  ProductModel productObj000 = ProductModel(
                      id: element000["id"],
                      category: element000["category"],
                      name: element000["name"],
                      price: element000["price"],
                      extras: [],
                      hasExtra: element000["hasExtra"],
                      returned: element000["returned"],
                      wentToKitchen: element000["wentToKitchen"],
                      printerId: element000["printerId"]);

                  if (element000["extras"] != null) {
                    element000["extras"].forEach((element) {
                      final extraObj = ExtraModel(
                          category: element["category"],
                          content: element["content"],
                          status: element["status"],
                          price: element["price"]);
                      productObj000.extras!.add(extraObj);
                    });
                  }
                  productListObj00.products!.add(productObj000);
                });
                // productListObj00.products!.add(product);
                table.products!.add(productListObj00);
              },
            );

            value["removedProducts"].forEach((element) {
              ProductModel product = ProductModel(
                  id: element["product"]["id"],
                  category: element["product"]["category"],
                  name: element["product"]["name"],
                  price: element["product"]["price"],
                  extras: [],
                  hasExtra: element["product"]["hasExtra"],
                  returned: element["product"]["returned"],
                  wentToKitchen: element["product"]["wentToKitchen"],
                  printerId: element["product"]["printerId"]);

              if (element["product"]["extras"] != null) {
                element["product"]["extras"].forEach((element) {
                  final extraObj = ExtraModel(
                      category: element["category"],
                      content: element["content"],
                      status: element["status"],
                      price: element["price"]);
                  product.extras!.add(extraObj);
                });
              }

              ProductListModel productListObj00 = ProductListModel(
                  products: [],
                  product: product,
                  count: (element["count"] != null) ? element["count"] : 1,
                  total: (element["total"] != null) ? element["total"] : 0.00);
              element["products"].forEach((element000) {
                ProductModel productObj000 = ProductModel(
                    id: element000["id"],
                    category: element000["category"],
                    name: element000["name"],
                    price: element000["price"],
                    extras: [],
                    hasExtra: element000["hasExtra"],
                    returned: element000["returned"],
                    wentToKitchen: element000["wentToKitchen"],
                    printerId: element000["printerId"]);

                if (element000["extras"] != null) {
                  element000["extras"].forEach((element) {
                    final extraObj = ExtraModel(
                        category: element["category"],
                        content: element["content"],
                        status: element["status"],
                        price: element["price"]);
                    productObj000.extras!.add(extraObj);
                  });
                }
                productListObj00.products!.add(productObj000);
              });
              table.removedProducts!.add(productListObj00);
            });

            if (value["returnedProducts"] != null) {
              value["returnedProducts"].forEach((element) {
                ProductModel product = ProductModel(
                    id: element["product"]["id"],
                    category: element["product"]["category"],
                    name: element["product"]["name"],
                    price: element["product"]["price"],
                    extras: []);

                if (element["product"]["extras"] != null) {
                  element["product"]["extras"].forEach((element) {
                    final extraObj = ExtraModel(
                        category: element["category"],
                        content: element["content"],
                        status: element["status"],
                        price: element["price"]);
                    product.extras!.add(extraObj);
                  });
                }

                ReturnedProductListModel productListObj00 =
                    ReturnedProductListModel(
                        products: [],
                        product: product,
                        count:
                            (element["count"] != null) ? element["count"] : 1,
                        date: DateTime.parse(element["date"]),
                        billNumber: element["billNumber"],
                        tableNumber: element["tableNumber"],
                        total: (element["total"] != null)
                            ? element["total"]
                            : 0.00);
                element["products"].forEach((element000) {
                  ProductModel productObj000 = ProductModel(
                      id: element000["id"],
                      category: element000["category"],
                      name: element000["name"],
                      price: element000["price"],
                      extras: [],
                      hasExtra: element000["hasExtra"],
                      returned: element000["returned"],
                      wentToKitchen: element000["wentToKitchen"],
                      printerId: element000["printerId"]);

                  if (element000["extras"] != null) {
                    element000["extras"].forEach((element) {
                      final extraObj = ExtraModel(
                          category: element["category"],
                          content: element["content"],
                          status: element["status"],
                          price: element["price"]);
                      productObj000.extras!.add(extraObj);
                    });
                  }
                  productListObj00.products!.add(productObj000);
                });
                table.returnedProducts!.add(productListObj00);
              });
            }

            if (value["partialPaidProducts"] != null) {
              value["partialPaidProducts"].forEach(
                (element) {
                  ProductModel product = ProductModel(
                      id: element["product"]["id"],
                      category: element["product"]["category"],
                      name: element["product"]["name"],
                      price: element["product"]["price"],
                      extras: [],
                      hasExtra: element["product"]["hasExtra"],
                      returned: element["product"]["returned"],
                      wentToKitchen: element["product"]["wentToKitchen"],
                      printerId: element["product"]["printerId"]);

                  if (element["product"]["extras"] != null) {
                    element["product"]["extras"].forEach((element) {
                      final extraObj = ExtraModel(
                          category: element["category"],
                          content: element["content"],
                          status: element["status"],
                          price: element["price"]);
                      product.extras!.add(extraObj);
                    });
                  }

                  ProductListModel productListObj00 = ProductListModel(
                      products: [],
                      product: product,
                      count: (element["count"] != null) ? element["count"] : 1,
                      total:
                          (element["total"] != null) ? element["total"] : 0.00);

                  element["products"].forEach((element000) {
                    ProductModel productObj000 = ProductModel(
                        id: element000["id"],
                        category: element000["category"],
                        name: element000["name"],
                        price: element000["price"],
                        extras: [],
                        hasExtra: element000["hasExtra"],
                        returned: element000["returned"],
                        wentToKitchen: element000["wentToKitchen"],
                        printerId: element000["printerId"]);

                    if (element000["extras"] != null) {
                      element000["extras"].forEach((element) {
                        final extraObj = ExtraModel(
                            category: element["category"],
                            content: element["content"],
                            status: element["status"],
                            price: element["price"]);
                        productObj000.extras!.add(extraObj);
                      });
                    }
                    productListObj00.products!.add(productObj000);
                  });
                  // productListObj00.products!.add(product);
                  table.partialPaidProducts!.add(productListObj00);
                },
              );
            }

            if (value["partialNotPaidProducts"] != null) {
              value["partialNotPaidProducts"].forEach(
                (element) {
                  ProductModel product = ProductModel(
                      id: element["product"]["id"],
                      category: element["product"]["category"],
                      name: element["product"]["name"],
                      price: element["product"]["price"],
                      extras: [],
                      hasExtra: element["product"]["hasExtra"],
                      returned: element["product"]["returned"],
                      wentToKitchen: element["product"]["wentToKitchen"],
                      printerId: element["product"]["printerId"]);

                  if (element["product"]["extras"] != null) {
                    element["product"]["extras"].forEach((element) {
                      final extraObj = ExtraModel(
                          category: element["category"],
                          content: element["content"],
                          status: element["status"],
                          price: element["price"]);
                      product.extras!.add(extraObj);
                    });
                  }

                  ProductListModel productListObj00 = ProductListModel(
                      products: [],
                      product: product,
                      count: (element["count"] != null) ? element["count"] : 1,
                      total:
                          (element["total"] != null) ? element["total"] : 0.00);

                  element["products"].forEach((element000) {
                    ProductModel productObj000 = ProductModel(
                        id: element000["id"],
                        category: element000["category"],
                        name: element000["name"],
                        price: element000["price"],
                        extras: [],
                        hasExtra: element000["hasExtra"],
                        returned: element000["returned"],
                        wentToKitchen: element000["wentToKitchen"],
                        printerId: element000["printerId"]);

                    if (element000["extras"] != null) {
                      element000["extras"].forEach((element) {
                        final extraObj = ExtraModel(
                            category: element["category"],
                            content: element["content"],
                            status: element["status"],
                            price: element["price"]);
                        productObj000.extras!.add(extraObj);
                      });
                    }
                    productListObj00.products!.add(productObj000);
                  });
                  // productListObj00.products!.add(product);
                  if (table.partialNotPaidProducts == null) {
                    table.partialNotPaidProducts = [];
                  }
                  table.partialNotPaidProducts!.add(productListObj00);
                },
              );
            }

            if (value["partialPaidConfirmedProducts"] != null) {
              value["partialPaidConfirmedProducts"].forEach(
                (element) {
                  ProductModel product = ProductModel(
                      id: element["product"]["id"],
                      category: element["product"]["category"],
                      name: element["product"]["name"],
                      price: element["product"]["price"],
                      extras: [],
                      hasExtra: element["product"]["hasExtra"],
                      returned: element["product"]["returned"],
                      wentToKitchen: element["product"]["wentToKitchen"],
                      printerId: element["product"]["printerId"]);

                  if (element["product"]["extras"] != null) {
                    element["product"]["extras"].forEach((element) {
                      final extraObj = ExtraModel(
                          category: element["category"],
                          content: element["content"],
                          status: element["status"],
                          price: element["price"]);
                      product.extras!.add(extraObj);
                    });
                  }

                  ProductListModel productListObj00 = ProductListModel(
                      products: [],
                      product: product,
                      count: (element["count"] != null) ? element["count"] : 1,
                      total:
                          (element["total"] != null) ? element["total"] : 0.00);

                  element["products"].forEach((element000) {
                    ProductModel productObj000 = ProductModel(
                        id: element000["id"],
                        category: element000["category"],
                        name: element000["name"],
                        price: element000["price"],
                        extras: [],
                        hasExtra: element000["hasExtra"],
                        returned: element000["returned"],
                        wentToKitchen: element000["wentToKitchen"],
                        printerId: element000["printerId"]);

                    if (element000["extras"] != null) {
                      element000["extras"].forEach((element) {
                        final extraObj = ExtraModel(
                            category: element["category"],
                            content: element["content"],
                            status: element["status"],
                            price: element["price"]);
                        productObj000.extras!.add(extraObj);
                      });
                    }
                    productListObj00.products!.add(productObj000);
                  });
                  // productListObj00.products!.add(product);
                  table.partialPaidConfirmedProducts!.add(productListObj00);
                },
              );
            }

            tables.add(table);
          } else {
            tables.add(value);
          }
        });
        calculateTotal();
        update();
      }
    }
  }

  void initZReportTable() {
    if (depo.read("zReportTable") != null) {
      var tempList = jsonDecode(depo.read("zReportTable"));
      // print(tempList);
      if (tempList != null) {
        if (tempList.runtimeType != TableModel) {
          TableModel table = TableModel(
              id: tempList["id"],
              name: tempList["name"],
              products: [],
              removedProducts: [],
              returnedProducts: [],
              partialPaidProducts: [],
              partialNotPaidProducts: [],
              partialPaidConfirmedProducts: [],
              total: tempList["total"],
              totalPaid: tempList["totalPaid"],
              totalNotPaid: tempList["totalNotPaid"],
              totalWillPay: tempList["totalWillPay"],
              note: tempList["note"]);
          tempList["products"].forEach((element) {
            ProductModel product = ProductModel(
                id: element["product"]["id"],
                category: element["product"]["category"],
                name: element["product"]["name"],
                price: element["product"]["price"],
                extras: [],
                hasExtra: element["product"]["hasExtra"],
                returned: element["product"]["returned"],
                wentToKitchen: element["product"]["wentToKitchen"],
                printerId: element["product"]["printerId"]);

            if (element["product"]["extras"] != null) {
              element["product"]["extras"].forEach((element) {
                final extraObj = ExtraModel(
                    category: element["category"],
                    content: element["content"],
                    status: element["status"],
                    price: element["price"]);
                product.extras!.add(extraObj);
              });
            }

            ProductListModel productListObj00 = ProductListModel(
                products: [],
                product: product,
                count: (element["count"] != null) ? element["count"] : 1,
                total: (element["total"] != null) ? element["total"] : 0.00);
            productListObj00.products!.add(product);
            table.products!.add(productListObj00);
          });

          tempList["removedProducts"].forEach((element) {
            ProductModel product = ProductModel(
                id: element["product"]["id"],
                category: element["product"]["category"],
                name: element["product"]["name"],
                price: element["product"]["price"],
                extras: [],
                hasExtra: element["product"]["hasExtra"],
                returned: element["product"]["returned"],
                wentToKitchen: element["product"]["wentToKitchen"],
                printerId: element["product"]["printerId"]);

            if (element["product"]["extras"] != null) {
              element["product"]["extras"].forEach((element) {
                final extraObj = ExtraModel(
                    category: element["category"],
                    content: element["content"],
                    status: element["status"],
                    price: element["price"]);
                product.extras!.add(extraObj);
              });
            }

            ProductListModel productListObj00 = ProductListModel(
                products: [],
                product: product,
                count: (element["count"] != null) ? element["count"] : 1,
                total: (element["total"] != null) ? element["total"] : 0.00);
            productListObj00.products!.add(product);
            table.removedProducts!.add(productListObj00);
          });

          if (tempList["returnedProducts"] != null) {
            tempList["returnedProducts"].forEach((element) {
              ProductModel product = ProductModel(
                  id: element["product"]["id"],
                  category: element["product"]["category"],
                  name: element["product"]["name"],
                  price: element["product"]["price"],
                  extras: [],
                  hasExtra: element["product"]["hasExtra"],
                  returned: element["product"]["returned"],
                  wentToKitchen: element["product"]["wentToKitchen"],
                  printerId: element["product"]["printerId"]);

              if (element["product"]["extras"] != null) {
                element["product"]["extras"].forEach((element) {
                  final extraObj = ExtraModel(
                      category: element["category"],
                      content: element["content"],
                      status: element["status"],
                      price: element["price"]);
                  product.extras!.add(extraObj);
                });
              }

              ReturnedProductListModel productListObj00 =
                  ReturnedProductListModel(
                      products: [],
                      product: product,
                      count: (element["count"] != null) ? element["count"] : 1,
                      date: DateTime.parse(element["date"]),
                      billNumber: element["billNumber"],
                      tableNumber: element["tableNumber"],
                      total:
                          (element["total"] != null) ? element["total"] : 0.00);
              productListObj00.products!.add(product);
              table.returnedProducts!.add(productListObj00);
            });
          }

          if (tempList["partialPaidProducts"] != null) {
            tempList["partialPaidProducts"].forEach(
              (element) {
                ProductModel product = ProductModel(
                    id: element["product"]["id"],
                    category: element["product"]["category"],
                    name: element["product"]["name"],
                    price: element["product"]["price"],
                    extras: [],
                    hasExtra: element["product"]["hasExtra"],
                    returned: element["product"]["returned"],
                    wentToKitchen: element["product"]["wentToKitchen"],
                    printerId: element["product"]["printerId"]);

                if (element["product"]["extras"] != null) {
                  element["product"]["extras"].forEach((element) {
                    final extraObj = ExtraModel(
                        category: element["category"],
                        content: element["content"],
                        status: element["status"],
                        price: element["price"]);
                    product.extras!.add(extraObj);
                  });
                }

                ProductListModel productListObj00 = ProductListModel(
                    products: [],
                    product: product,
                    count: (element["count"] != null) ? element["count"] : 1,
                    total:
                        (element["total"] != null) ? element["total"] : 0.00);

                element["products"].forEach((element000) {
                  ProductModel productObj000 = ProductModel(
                      id: element000["id"],
                      category: element000["category"],
                      name: element000["name"],
                      price: element000["price"],
                      extras: [],
                      hasExtra: element000["hasExtra"],
                      returned: element000["returned"],
                      wentToKitchen: element000["wentToKitchen"],
                      printerId: element000["printerId"]);

                  if (element000["extras"] != null) {
                    element000["extras"].forEach((element) {
                      final extraObj = ExtraModel(
                          category: element["category"],
                          content: element["content"],
                          status: element["status"],
                          price: element["price"]);
                      productObj000.extras!.add(extraObj);
                    });
                  }
                  productListObj00.products!.add(productObj000);
                });
                // productListObj00.products!.add(product);
                table.partialPaidProducts!.add(productListObj00);
              },
            );
          }

          if (tempList["partialNotPaidProducts"] != null) {
            tempList["partialNotPaidProducts"].forEach(
              (element) {
                ProductModel product = ProductModel(
                    id: element["product"]["id"],
                    category: element["product"]["category"],
                    name: element["product"]["name"],
                    price: element["product"]["price"],
                    extras: [],
                    hasExtra: element["product"]["hasExtra"],
                    returned: element["product"]["returned"],
                    wentToKitchen: element["product"]["wentToKitchen"],
                    printerId: element["product"]["printerId"]);

                if (element["product"]["extras"] != null) {
                  element["product"]["extras"].forEach((element) {
                    final extraObj = ExtraModel(
                        category: element["category"],
                        content: element["content"],
                        status: element["status"],
                        price: element["price"]);
                    product.extras!.add(extraObj);
                  });
                }

                ProductListModel productListObj00 = ProductListModel(
                    products: [],
                    product: product,
                    count: (element["count"] != null) ? element["count"] : 1,
                    total:
                        (element["total"] != null) ? element["total"] : 0.00);

                element["products"].forEach((element000) {
                  ProductModel productObj000 = ProductModel(
                      id: element000["id"],
                      category: element000["category"],
                      name: element000["name"],
                      price: element000["price"],
                      extras: [],
                      hasExtra: element000["hasExtra"],
                      returned: element000["returned"],
                      wentToKitchen: element000["wentToKitchen"],
                      printerId: element000["printerId"]);

                  if (element000["extras"] != null) {
                    element000["extras"].forEach((element) {
                      final extraObj = ExtraModel(
                          category: element["category"],
                          content: element["content"],
                          status: element["status"],
                          price: element["price"]);
                      productObj000.extras!.add(extraObj);
                    });
                  }
                  productListObj00.products!.add(productObj000);
                });
                // productListObj00.products!.add(product);
                table.partialNotPaidProducts!.add(productListObj00);
              },
            );
          }

          if (tempList["partialPaidConfirmedProducts"] != null) {
            tempList["partialPaidConfirmedProducts"].forEach(
              (element) {
                ProductModel product = ProductModel(
                    id: element["product"]["id"],
                    category: element["product"]["category"],
                    name: element["product"]["name"],
                    price: element["product"]["price"],
                    extras: [],
                    hasExtra: element["product"]["hasExtra"],
                    returned: element["product"]["returned"],
                    wentToKitchen: element["product"]["wentToKitchen"],
                    printerId: element["product"]["printerId"]);

                if (element["product"]["extras"] != null) {
                  element["product"]["extras"].forEach((element) {
                    final extraObj = ExtraModel(
                        category: element["category"],
                        content: element["content"],
                        status: element["status"],
                        price: element["price"]);
                    product.extras!.add(extraObj);
                  });
                }

                ProductListModel productListObj00 = ProductListModel(
                    products: [],
                    product: product,
                    count: (element["count"] != null) ? element["count"] : 1,
                    total:
                        (element["total"] != null) ? element["total"] : 0.00);

                element["products"].forEach((element000) {
                  ProductModel productObj000 = ProductModel(
                      id: element000["id"],
                      category: element000["category"],
                      name: element000["name"],
                      price: element000["price"],
                      extras: [],
                      hasExtra: element000["hasExtra"],
                      returned: element000["returned"],
                      wentToKitchen: element000["wentToKitchen"],
                      printerId: element000["printerId"]);

                  if (element000["extras"] != null) {
                    element000["extras"].forEach((element) {
                      final extraObj = ExtraModel(
                          category: element["category"],
                          content: element["content"],
                          status: element["status"],
                          price: element["price"]);
                      productObj000.extras!.add(extraObj);
                    });
                  }
                  productListObj00.products!.add(productObj000);
                });
                // productListObj00.products!.add(product);
                table.partialPaidConfirmedProducts!.add(productListObj00);
              },
            );
          }

          zReportTable = table;
          update();
        }
      }
    }
  }

  void changeStatus(int tableNumber, int productList, int currentProduct, int i,
      int index, bool value) {
    if (tables[tableNumber]
            .products![productList]
            .products![currentProduct]
            .extras ==
        null) {
      tables[tableNumber]
          .products![productList]
          .products![currentProduct]
          .extras = [];
    }
    if (tables[tableNumber]
        .products![productList]
        .products![currentProduct]
        .extras!
        .where((element) =>
            element.content ==
                extras
                    .where((element) => element.category == extraCategories[i]!)
                    .toList()[index]
                    .content &&
            element.status == value)
        .isEmpty) {
      tables[tableNumber]
          .products![productList]
          .products![currentProduct]
          .extras!
          .add(extras
              .where((element) => element.category == extraCategories[i]!)
              .toList()[index]);
      tables[tableNumber]
          .products![productList]
          .products![currentProduct]
          .extras!
          .last
          .status = value;
      if (tables[tableNumber]
              .products![productList]
              .products![currentProduct]
              .extras!
              .last
              .price !=
          null) {
        // Add new price
        ProductModel pseudoProduct = ProductModel(
          id: 9999,
          category: "Extra",
          name: tables[tableNumber]
              .products![productList]
              .products![currentProduct]
              .extras!
              .last
              .content,
          price: tables[tableNumber]
              .products![productList]
              .products![currentProduct]
              .extras!
              .last
              .price,
        );
        // Add Extra Price as new product
        addProduct2Table(tableNumber, pseudoProduct, 1);
      }
    } else if (tables[tableNumber]
        .products![productList]
        .products![currentProduct]
        .extras!
        .where((element) =>
            element.content ==
                extras
                    .where((element) => element.category == extraCategories[i]!)
                    .toList()[index]
                    .content &&
            element.status == value)
        .isNotEmpty) {
      tables[tableNumber]
          .products![productList]
          .products![currentProduct]
          .extras!
          .remove(currentTable
              .products![productList].products![currentProduct].extras!
              .firstWhere((element) =>
                  element.content ==
                      extras
                          .where((element) =>
                              element.category == extraCategories[i]!)
                          .toList()[index]
                          .content &&
                  element.status == value));
    }

    update();
    var tablesEncoded = jsonEncode(tables);
    print(tablesEncoded);
    depo.write("tables", tablesEncoded);
    unawaited(initProducts());
  }

 
  String createBillNumber() {
    const chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/";
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < 128; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    int j = 0;
    final dashes = {
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25
    };
    String billNumber = result.splitMapJoin(RegExp('.....'), onNonMatch: (s) {
      if (j == 25) {
        return "-" + s;
      } else if (j > 25) {
        return s;
      }
      return dashes.contains(j++) ? '-' : '';
    });
    return billNumber;
  }

  String createCertificateNumber() {
    const chars0 = "ABCDEF0123456789";
    Random rnd0 = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result0 = "";
    for (var i = 0; i < 64; i++) {
      result0 += chars0[rnd0.nextInt(chars0.length)];
    }
    String certificateNumber = result0;
    return certificateNumber;
  }


  void removeEverythings() {
    depo.remove("tables");
    depo.remove("zReportTable");
    depo.remove("bills");
    depo.remove("hesaplar");
    tables = [];
    initTables();
    currentTable = TableModel();
    update();
    Get.back();
    // depo.write("ztoplam", 0.00);
    // depo.write("zstorno", 0.00);
    // depo.write("zAciklama", "");

    total = 0.00.obs;
    totalBill = 0.00;
    zReportTable = TableModel(
        id: 0,
        name: "Z-Berich",
        products: [],
        removedProducts: [],
        returnedProducts: [],
        total: 0);
    //extraCategories = [];
    currentTable = TableModel();
    bills = [];
    currentBill = TableModel();
    billPrinted = 0;

    update();

    Get.snackbar("Removed", "Everything is removed");
  }

  // void removeEverythingsExeptTables() {
  //   depo.remove("tables");
  //   depo.remove("zReportTable");
  //   depo.remove("bills");
  //   tables = [];
  //   initTables();
  //   currentTable = TableModel();
  //   update();
  //   Get.back();
  //   // depo.write("ztoplam", 0.00);
  //   // depo.write("zstorno", 0.00);
  //   depo.write("zAciklama", "");

  //   Get.snackbar("Removed", "Everything is removed");
  // }

  // Print with Bluetooth

  Future<bool> printWithoutBluetooth(BuildContext context, String billNumber,
      String certificateNumber, bool isPartial) async {
    context.loaderOverlay.show();

    // DEMO RECEIPT
    final Map<String, dynamic> res =
        await initPageForBill(billNumber, certificateNumber, isPartial);
    print(json.encode(res));

    if (res.isNotEmpty) {
      Future.delayed(Duration(seconds: 1), () {
        context.loaderOverlay.hide();
        Future.delayed(Duration(milliseconds: 10), () {
          Get.offAllNamed(Routes.BILLCONFIRM, arguments: {
            "billNumber": billNumber,
            "certificateNumber": certificateNumber,
            "isPartial": isPartial,
            "detail": res
          });
        });
      });
    } else {
      Get.snackbar("Uyarı", "Yazdirma Hatasi Servisi Arayin, ");
      context.loaderOverlay.hide();
      return false;
    }
    return true;
  }

  Future<Map<String, dynamic>> initPageForBill(
      String billNumber, String certificateNumber, bool isPartial) async {


    Map<String, dynamic> res = {};
    var products = [];

    res["table"] = currentTable.name!;

    if (isPartial) {
      // Partial Start
      for (var i = 0;
          i < currentTable.partialPaidConfirmedProducts!.length;
          i++) {
        for (var j = 0;
            j < currentTable.partialPaidConfirmedProducts![i].products!.length;
            j++) {
          products.add({
            "name": currentTable
                .partialPaidConfirmedProducts![i].products![j].name!,
            "price": "EUR " +
                currentTable
                    .partialPaidConfirmedProducts![i].products![j].price!
                    .toStringAsFixed(2)
          });
        }
      }

      double toplam = 0.00;
      for (var i = 0;
          i < currentTable.partialPaidConfirmedProducts!.length;
          i++) {
        print(
            "Urun ${currentTable.partialPaidConfirmedProducts![i].product!.name!} Fiyat: ${currentTable.partialPaidConfirmedProducts![i].product!.price!}");
        toplam +=
            currentTable.partialPaidConfirmedProducts![i].product!.price! *
                currentTable.partialPaidConfirmedProducts![i].count!;
      }

      double mwst = (toplam * 0.19);
      double umsatz = toplam - mwst;

      double mwst2 = (toplam * 0.07);
      double umsatz2 = toplam - mwst2;

      res["nwst19"] = "EUR " + mwst.toStringAsFixed(2);
      res["umsatz19"] = "EUR " + umsatz.toStringAsFixed(2);
      res["nwst7"] = "EUR " + mwst2.toStringAsFixed(2);
      res["umsatz7"] = "EUR " + umsatz2.toStringAsFixed(2);
      res["total"] = "EUR " + toplam.toStringAsFixed(2);
      res["bar"] = "EUR " + toplam.toStringAsFixed(2);

      final now = DateTime.now();
      final formatter = DateFormat('MM/dd/yyyy HH:mm');
      final String timestamp = formatter.format(now);

      res["datum"] = timestamp;

      final random2 = Random();
     
      String transaktion = (random2.nextInt(9000) + 1000).toString();
      String signaturzahler = (random2.nextInt(20000) + 10000).toString();

      res["transaktion"] = "Transaktion: " +
          transaktion +
          " | " +
          "Signaturzahler: " +
          signaturzahler;

      res["zertifikat"] = "Zertifikat Seriennr.:" + certificateNumber;
      res["billNumber"] = billNumber;
      res["products"] = products;

      // Add products of current table to z-report
      for (var i = 0;
          i < currentTable.partialPaidConfirmedProducts!.length;
          i++) {
        for (var j = 0;
            j < currentTable.partialPaidConfirmedProducts![i].products!.length;
            j++) {
          addProduct2ZReport(
              currentTable.partialPaidConfirmedProducts![i].products![j]);
        }
      }
      // Partial End
    } else {
      print("Not partial");

      for (var i = 0; i < currentTable.products!.length; i++) {
        for (var j = 0; j < currentTable.products![i].products!.length; j++) {
          print("I'm here $i, $j");
          products.add({
            "name": currentTable.products![i].products![j].name!,
            "price": "EUR " +
                currentTable.products![i].products![j].price!.toStringAsFixed(2)
          });
        }
      }

      double toplam = 0.00;
      for (var i = 0; i < currentTable.products!.length; i++) {
        print(
            "Urun ${currentTable.products![i].product!.name!} Fiyat: ${currentTable.products![i].product!.price!}");
        toplam += currentTable.products![i].product!.price! *
            currentTable.products![i].count!;
      }

      double mwst = (toplam * 0.19);
      double umsatz = toplam - mwst;

      double mwst2 = (toplam * 0.07);
      double umsatz2 = toplam - mwst2;

      res["nwst19"] = " €" + mwst.toStringAsFixed(2);
      res["umsatz19"] = " €" + umsatz.toStringAsFixed(2);
      res["nwst7"] = " €" + mwst2.toStringAsFixed(2);
      res["umsatz7"] = " €" + umsatz2.toStringAsFixed(2);
      res["total"] = " €" + toplam.toStringAsFixed(2);
      res["bar"] = " €" + toplam.toStringAsFixed(2);

      final now = DateTime.now();
      final formatter = DateFormat('MM/dd/yyyy HH:mm');
      final String timestamp = formatter.format(now);

      res["datum"] = timestamp;

      final random2 = Random();
     
      String transaktion = (random2.nextInt(9000) + 1000).toString();
      String signaturzahler = (random2.nextInt(20000) + 10000).toString();

      res["transaktion"] = "Transaktion: " +
          transaktion +
          " | " +
          "Signaturzahler: " +
          signaturzahler;

      res["zertifikat"] = "Zertifikat Seriennr.:" + certificateNumber;
      res["billNumber"] = billNumber;
      res["products"] = products;

      // Add products of current table to z-report
      for (var i = 0; i < currentTable.products!.length; i++) {
        for (var j = 0; j < currentTable.products![i].products!.length; j++) {
          addProduct2ZReport(currentTable.products![i].products![j]);
        }
      }
    }

    return res;
  }



    // for (var i = 0; i < currentTable.products!.length; i++) {
    //   List<ProductModel> notWentToKitchen = currentTable.products![i].products!
    //       .where((element) =>
    //           element.wentToKitchen == false || element.wentToKitchen == null)
    //       .toList();
    //   for (var j = 0; j < notWentToKitchen.length; j++) {
    //     printer.row(
    //       [
    //         PosColumn(
    //             text: notWentToKitchen[j].name! + " ",
    //             width: 9,
    //             styles: PosStyles(
    //                 align: PosAlign.left,
    //                 //bold: false,
    //                 height: PosTextSize.size2,
    //                 width: PosTextSize.size2)),
    //         PosColumn(
    //             text: notWentToKitchen[j].price!.toStringAsFixed(2),
    //             width: 3,
    //             styles: PosStyles(
    //                 align: PosAlign.right,
    //                 bold: false,
    //                 height: PosTextSize.size1,
    //                 width: PosTextSize.size1)),
    //       ],
    //     );

    //     if (notWentToKitchen[j].extras != null &&
    //         notWentToKitchen[j].extras!.isNotEmpty)
    //       for (var l = 0; l < notWentToKitchen[j].extras!.length; l++) {
    //         printer.text(
    //           "    -" + notWentToKitchen[j].extras![l].content!,
    //           styles: PosStyles(
    //               align: PosAlign.left,
    //               height: PosTextSize.size2,
    //               width: PosTextSize.size2),
    //         );
    //       }

    //     printer.hr();
    //   }
    // }


  @override
  void onInit() {
    super.onInit();
    depo.write("tables", null);
    initTables();
    unawaited(initProducts());
    initBillCount();
    initZReportTable();
    initBills();

    /*  depo.write("dukkan", "KOZ BINGOL");
    depo.write("adresse", "Langenhorner CH. 655");
    depo.write("plz", "22419,Hamburg");
    depo.write("telefon", "040-53035550");
    depo.write("steuer", "49/610/01566");
    depo.write("bediener", " ");

    //////////////////////////Gercek Yazici Parametreleri

    depo.write("ipprinter0", "192.168.2.28");
    depo.write("ipprinter1", "192.168.2.28");
    depo.write("ipprinter2", "192.168.2.28");
    depo.write("ipprinter3", "192.168.2.28");
    depo.write("btprinter", "57:4C:54:02:7E:C3"); //Pri */

    //////////////////////////////////////////////////////

    /////////// Test

    // depo.write("ipprinter0", "192.168.0.238");
    // depo.write("ipprinter1", "192.168.0.238");
    // depo.write("ipprinter2", "192.168.0.238");
    // depo.write("ipprinter3", "192.168.0.238");
    // depo.write("btprinter", "88:BD:45:B0:4F:2D");

    ///////////////////////////

    //depo.write("btprinter", "57:4C:54:02:7E:C3"); //Printer1
    //depo.write("btprinter", "88:BD:45:B0:4F:2D"); // Virtual Printer
    //depo.write("btprinter", "57:4C:54:02:41:31"); //Azim Mac : 57:43:54:02:7B:72
    // depo.write("btprinter", "0F:02:18:B2:02:F3"); //Büro Mac
  }

  void addProduct2ZReport(ProductModel? product) {
    // ignore: unused_local_variable
    int lastIndex = 0;
    if (zReportTable.products!
        .where((element) => element.product!.id == product!.id)
        .isNotEmpty) {
      ProductListModel productListObj = zReportTable.products!
          .firstWhere((element) => element.product!.id == product!.id);
      ProductListModel productListObjReplicate =
          ProductListModel.fromJson(productListObj.toJson());
      zReportTable.products!.remove(productListObj);
      productListObjReplicate.count = productListObjReplicate.count! + 1;
      productListObjReplicate.total = productListObjReplicate.count! *
          productListObjReplicate.product!.price!;
      productListObjReplicate.products!.add(product!);
      lastIndex = productListObjReplicate.products!
          .indexOf(productListObjReplicate.products!.last);
      zReportTable.products!.add(productListObjReplicate);
    } else {
      ProductListModel productListObj0 = ProductListModel(
          products: [],
          product: product,
          count: 1,
          total: (product!.price! * 1));
      productListObj0.products!.add(product);
      zReportTable.products!.add(productListObj0);

      lastIndex =
          productListObj0.products!.indexOf(productListObj0.products!.last);
    }
    update();

    //calculateTotal();
   
    //depo.write("zReportTable", tablesEncoded);
    update();
  }

  void removeProduct2ZReportTable(ProductModel? product) {
    // ignore: unused_local_variable
    int lastIndex = 0;
    if (zReportTable.removedProducts!
        .where((element) => element.product!.id == product!.id)
        .isNotEmpty) {
      ProductListModel productListObj = zReportTable.removedProducts!
          .firstWhere((element) => element.product!.id == product!.id);
      ProductListModel productListObjReplicate =
          ProductListModel.fromJson(productListObj.toJson());
      zReportTable.removedProducts!.remove(productListObj);
      productListObjReplicate.count = productListObjReplicate.count! + 1;
      productListObjReplicate.total = productListObjReplicate.count! *
          productListObjReplicate.product!.price!;
      productListObjReplicate.products!.add(product!);
      lastIndex = productListObjReplicate.products!
          .indexOf(productListObjReplicate.products!.last);
      zReportTable.removedProducts!.add(productListObjReplicate);
    } else {
      ProductListModel productListObj0 = ProductListModel(
          products: [],
          product: product,
          count: 1,
          total: (product!.price! * 1));
      productListObj0.products!.add(product);
      zReportTable.removedProducts!.add(productListObj0);

      lastIndex =
          productListObj0.products!.indexOf(productListObj0.products!.last);
    }
    update();

    
    // depo.write("zReportTable", tablesEncoded);
    update();
  }

  void add2BillsList(TableModel tableObj, bool isPartial) {
    bills.add(tableObj.copyWith(id: Random().nextInt(1000000)));
    
    //depo.write("bills", tablesEncoded);
    update();
    print(bills.toString());
  }

  void initBills() {
    if (depo.read("bills") == null) {
      return;
    }
    var tempList = jsonDecode(depo.read("bills"));
    if (tempList != null) {
      tempList.forEach((value) {
        if (value.runtimeType != TableModel) {
          TableModel table = TableModel(
              id: value["id"],
              name: value["name"],
              products: [],
              removedProducts: [],
              total: value["total"],
              totalNotPaid: value["totalNotPaid"],
              totalPaid: value["totalPaid"],
              totalWillPay: value["totalWillPay"],
              partialNotPaidProducts: [],
              partialPaidConfirmedProducts: [],
              partialPaidProducts: [],
              note: value["note"]);
          value["products"].forEach((element) {
            ProductModel product = ProductModel(
                id: element["product"]["id"],
                category: element["product"]["category"],
                name: element["product"]["name"],
                price: element["product"]["price"],
                extras: []);
            if (element["product"]["extras"] != null) {
              element["product"]["extras"].forEach((element) {
                final extraObj = ExtraModel(
                    category: element["category"],
                    content: element["content"],
                    status: element["status"],
                    price: element["price"]);
                product.extras!.add(extraObj);
              });
            }

            ProductListModel productListObj00 = ProductListModel(
                products: [],
                product: product,
                count: (element["count"] != null) ? element["count"] : 1,
                total: (element["total"] != null) ? element["total"] : 0.00);
            productListObj00.products!.add(product);
            table.products!.add(productListObj00);
          });

          value["removedProducts"].forEach((element) {
            ProductModel product = ProductModel(
                id: element["product"]["id"],
                category: element["product"]["category"],
                name: element["product"]["name"],
                price: element["product"]["price"],
                extras: []);

            if (element["product"]["extras"] != null) {
              element["product"]["extras"].forEach((element) {
                final extraObj = ExtraModel(
                    category: element["category"],
                    content: element["content"],
                    status: element["status"],
                    price: element["price"]);
                product.extras!.add(extraObj);
              });
            }

            ProductListModel productListObj00 = ProductListModel(
                products: [],
                product: product,
                count: (element["count"] != null) ? element["count"] : 1,
                total: (element["total"] != null) ? element["total"] : 0.00);
            productListObj00.products!.add(product);
            table.removedProducts!.add(productListObj00);
          });

          if (value["returnedProducts"] != null) {
            value["returnedProducts"].forEach((element) {
              ProductModel product = ProductModel(
                  id: element["product"]["id"],
                  category: element["product"]["category"],
                  name: element["product"]["name"],
                  price: element["product"]["price"],
                  extras: []);

              if (element["product"]["extras"] != null) {
                element["product"]["extras"].forEach((element) {
                  final extraObj = ExtraModel(
                      category: element["category"],
                      content: element["content"],
                      status: element["status"],
                      price: element["price"]);
                  product.extras!.add(extraObj);
                });
              }

              ReturnedProductListModel productListObj00 =
                  ReturnedProductListModel(
                      products: [],
                      product: product,
                      count: (element["count"] != null) ? element["count"] : 1,
                      date: DateTime.parse(element["date"]),
                      billNumber: element["billNumber"],
                      tableNumber: element["tableNumber"],
                      total:
                          (element["total"] != null) ? element["total"] : 0.00);
              productListObj00.products!.add(product);
              table.returnedProducts!.add(productListObj00);
            });
          }

          if (value["partialPaidProducts"] != null) {
            value["partialPaidProducts"].forEach(
              (element) {
                ProductModel product = ProductModel(
                    id: element["product"]["id"],
                    category: element["product"]["category"],
                    name: element["product"]["name"],
                    price: element["product"]["price"],
                    extras: [],
                    hasExtra: element["product"]["hasExtra"],
                    returned: element["product"]["returned"],
                    wentToKitchen: element["product"]["wentToKitchen"],
                    printerId: element["product"]["printerId"]);

                if (element["product"]["extras"] != null) {
                  element["product"]["extras"].forEach((element) {
                    final extraObj = ExtraModel(
                        category: element["category"],
                        content: element["content"],
                        status: element["status"],
                        price: element["price"]);
                    product.extras!.add(extraObj);
                  });
                }

                ProductListModel productListObj00 = ProductListModel(
                    products: [],
                    product: product,
                    count: (element["count"] != null) ? element["count"] : 1,
                    total:
                        (element["total"] != null) ? element["total"] : 0.00);

                element["products"].forEach((element000) {
                  ProductModel productObj000 = ProductModel(
                      id: element000["id"],
                      category: element000["category"],
                      name: element000["name"],
                      price: element000["price"],
                      extras: [],
                      hasExtra: element000["hasExtra"],
                      returned: element000["returned"],
                      wentToKitchen: element000["wentToKitchen"],
                      printerId: element000["printerId"]);

                  if (element000["extras"] != null) {
                    element000["extras"].forEach((element) {
                      final extraObj = ExtraModel(
                          category: element["category"],
                          content: element["content"],
                          status: element["status"],
                          price: element["price"]);
                      productObj000.extras!.add(extraObj);
                    });
                  }
                  productListObj00.products!.add(productObj000);
                });
                // productListObj00.products!.add(product);
                table.partialPaidProducts!.add(productListObj00);
              },
            );
          }

          if (value["partialNotPaidProducts"] != null) {
            value["partialNotPaidProducts"].forEach(
              (element) {
                ProductModel product = ProductModel(
                    id: element["product"]["id"],
                    category: element["product"]["category"],
                    name: element["product"]["name"],
                    price: element["product"]["price"],
                    extras: [],
                    hasExtra: element["product"]["hasExtra"],
                    returned: element["product"]["returned"],
                    wentToKitchen: element["product"]["wentToKitchen"],
                    printerId: element["product"]["printerId"]);

                if (element["product"]["extras"] != null) {
                  element["product"]["extras"].forEach((element) {
                    final extraObj = ExtraModel(
                        category: element["category"],
                        content: element["content"],
                        status: element["status"],
                        price: element["price"]);
                    product.extras!.add(extraObj);
                  });
                }

                ProductListModel productListObj00 = ProductListModel(
                    products: [],
                    product: product,
                    count: (element["count"] != null) ? element["count"] : 1,
                    total:
                        (element["total"] != null) ? element["total"] : 0.00);

                element["products"].forEach((element000) {
                  ProductModel productObj000 = ProductModel(
                      id: element000["id"],
                      category: element000["category"],
                      name: element000["name"],
                      price: element000["price"],
                      extras: [],
                      hasExtra: element000["hasExtra"],
                      returned: element000["returned"],
                      wentToKitchen: element000["wentToKitchen"],
                      printerId: element000["printerId"]);

                  if (element000["extras"] != null) {
                    element000["extras"].forEach((element) {
                      final extraObj = ExtraModel(
                          category: element["category"],
                          content: element["content"],
                          status: element["status"],
                          price: element["price"]);
                      productObj000.extras!.add(extraObj);
                    });
                  }
                  productListObj00.products!.add(productObj000);
                });
                // productListObj00.products!.add(product);
                if (table.partialNotPaidProducts == null) {
                  table.partialNotPaidProducts = [];
                }
                table.partialNotPaidProducts!.add(productListObj00);
              },
            );
          }

          if (value["partialPaidConfirmedProducts"] != null) {
            value["partialPaidConfirmedProducts"].forEach(
              (element) {
                ProductModel product = ProductModel(
                    id: element["product"]["id"],
                    category: element["product"]["category"],
                    name: element["product"]["name"],
                    price: element["product"]["price"],
                    extras: [],
                    hasExtra: element["product"]["hasExtra"],
                    returned: element["product"]["returned"],
                    wentToKitchen: element["product"]["wentToKitchen"],
                    printerId: element["product"]["printerId"]);

                if (element["product"]["extras"] != null) {
                  element["product"]["extras"].forEach((element) {
                    final extraObj = ExtraModel(
                        category: element["category"],
                        content: element["content"],
                        status: element["status"],
                        price: element["price"]);
                    product.extras!.add(extraObj);
                  });
                }

                ProductListModel productListObj00 = ProductListModel(
                    products: [],
                    product: product,
                    count: (element["count"] != null) ? element["count"] : 1,
                    total:
                        (element["total"] != null) ? element["total"] : 0.00);

                element["products"].forEach((element000) {
                  ProductModel productObj000 = ProductModel(
                      id: element000["id"],
                      category: element000["category"],
                      name: element000["name"],
                      price: element000["price"],
                      extras: [],
                      hasExtra: element000["hasExtra"],
                      returned: element000["returned"],
                      wentToKitchen: element000["wentToKitchen"],
                      printerId: element000["printerId"]);

                  if (element000["extras"] != null) {
                    element000["extras"].forEach((element) {
                      final extraObj = ExtraModel(
                          category: element["category"],
                          content: element["content"],
                          status: element["status"],
                          price: element["price"]);
                      productObj000.extras!.add(extraObj);
                    });
                  }
                  productListObj00.products!.add(productObj000);
                });
                // productListObj00.products!.add(product);
                table.partialPaidConfirmedProducts!.add(productListObj00);
              },
            );
          }

          bills.add(table);
          update();
        }
      });
      update();
    }
  }

  void removeProductFromZReport(ProductModel? product) {
    ProductListModel productListObj = zReportTable.products!
        .firstWhere((element) => element.product!.id == product!.id);
    if (productListObj.count! == 1) {
      zReportTable.products!.remove(productListObj);
    } else if (productListObj.count! > 1) {
      productListObj.products!.remove(product);
      productListObj.count = productListObj.count! - 1;
      productListObj.total =
          productListObj.product!.price! * productListObj.count!;
      //table.products!.add(productListObj);
    }
  }

  Future<bool> returnProduct2ZReport(ProductModel? product, int billListId,
      String billNumber, String tableNumber, int index, int j) async {
    // ignore: unused_local_variable
    int lastIndex = 0;
    if (zReportTable.returnedProducts!
        .where((element) => element.product!.id == product!.id)
        .isNotEmpty) {
      ReturnedProductListModel productListObj = zReportTable.returnedProducts!
          .firstWhere((element) => element.product!.id == product!.id);
      ReturnedProductListModel productListObjReplicate =
          ReturnedProductListModel.fromJson(productListObj.toJson());
      zReportTable.returnedProducts!.remove(productListObj);
      productListObjReplicate.count = productListObjReplicate.count! + 1;
      productListObjReplicate.total = productListObjReplicate.count! *
          productListObjReplicate.product!.price!;
      productListObjReplicate.products!.add(product!);
      lastIndex = productListObjReplicate.products!
          .indexOf(productListObjReplicate.products!.last);
      zReportTable.returnedProducts!.add(productListObjReplicate);
      currentBill.products![index].products![j].returned = true;
      TableModel bill = bills.firstWhere((element) => element.id == billListId);
      bill.products![index].products![j].returned = true;
    } else {
      ReturnedProductListModel returnedProductListModel =
          ReturnedProductListModel(
              products: [],
              product: product,
              count: 1,
              date: DateTime.now(),
              billNumber: billNumber,
              tableNumber: tableNumber,
              total: (product!.price! * 1));
      returnedProductListModel.products!.add(product);
      zReportTable.returnedProducts!.add(returnedProductListModel);
      currentBill.products![index].products![j].returned = true;
      TableModel bill = bills.firstWhere((element) => element.id == billListId);
      bill.products![index].products![j].returned = true;
      update();
    }

    calculateTotal();
    var tablesEncoded = jsonEncode(zReportTable);
    //depo.write("zReportTable", tablesEncoded);
    var billsEncoded = jsonEncode(bills);
    //depo.write("bills", billsEncoded);
    update();
    removeProductFromZReport(product);
    return true;
  }

  Future<bool> returnAllProductFromBill2ZReport(
      int billListId, String billNumber, String tableNumber) async {
    // ignore: unused_local_variable
    int lastIndex = 0;
    currentBill.products!.forEach((element) {
      element.products!.forEach((element0) {
        if (zReportTable.returnedProducts!
            .where((element00) => element00.product!.id == element0.id)
            .isNotEmpty) {
          ReturnedProductListModel productListObj = zReportTable
              .returnedProducts!
              .firstWhere((element) => element.product!.id == element0.id);
          ReturnedProductListModel productListObjReplicate =
              ReturnedProductListModel.fromJson(productListObj.toJson());
          zReportTable.returnedProducts!.remove(productListObj);
          productListObjReplicate.count = productListObjReplicate.count! + 1;
          productListObjReplicate.total = productListObjReplicate.count! *
              productListObjReplicate.product!.price!;
          productListObjReplicate.products!.add(element0);
          lastIndex = productListObjReplicate.products!
              .indexOf(productListObjReplicate.products!.last);
          zReportTable.returnedProducts!.add(productListObjReplicate);
          element0.returned = true;
          TableModel bill =
              bills.firstWhere((element) => element.id == billListId);
          bill.products!.forEach((element0) {
            element0.products!.forEach((element1) {
              element1.returned = true;
            });
          });
        } else {
          ReturnedProductListModel returnedProductListModel =
              ReturnedProductListModel(
                  products: [],
                  product: element0,
                  count: 1,
                  date: DateTime.now(),
                  billNumber: billNumber,
                  tableNumber: tableNumber,
                  total: (element0.price! * 1));
          returnedProductListModel.products!.add(element0);
          zReportTable.returnedProducts!.add(returnedProductListModel);
          element0.returned = true;
          TableModel bill =
              bills.firstWhere((element) => element.id == billListId);
          bill.products!.forEach((element00) {
            element00.products!.forEach((element11) {
              element11.returned = true;
            });
          });
          update();
        }

        calculateTotal();
        var tablesEncoded = jsonEncode(zReportTable);
        //depo.write("zReportTable", tablesEncoded);
        var billsEncoded = jsonEncode(bills);
        //depo.write("bills", billsEncoded);
        update();
        removeProductFromZReport(element0);
      });
    });
    return true;
  }

  createCustomKitchenOrDrink(int oid, int tableId) {
    if (customProductNameController.text.isEmpty ||
        customProductPriceController.text.isEmpty) {
      return Get.snackbar("Fehler", "Bitte füllen Sie alle Felder aus",
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    try {
      double.parse(customProductPriceController.text);
    } catch (e) {
      return Get.snackbar("Fehler", "Bitte geben Sie einen gültigen Preis ein",
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    TableModel table = tables.firstWhere((element) => element.id == tableId);

    ProductModel product = ProductModel(
        id: 999 + Random.secure().nextInt(1000000),
        name: (oid == 1 ? "Kuche: " : "Getranke: ") +
            customProductNameController.text,
        price: double.parse(customProductPriceController.text),
        hasExtra: false,
        extras: [],
        returned: false,
        wentToKitchen: false);

    ProductListModel productListObj0 = ProductListModel(
        products: [], product: product, count: 1, total: (product.price! * 1));
    productListObj0.products!.add(product);
    table.products!.add(productListObj0);
    update();
    calculateTotal();
    var tablesEncoded = jsonEncode(tables);
    depo.write("tables", tablesEncoded);
    customProductNameController.clear();
    customProductPriceController.text = "0.00";
    update();

    Get.back();
  }

  createNote(int tableId) {
    TableModel table = tables.firstWhere((element) => element.id == tableId);
    table.note = customNoteController.text;
    currentTable.note = customNoteController.text;
    update();
    customNoteController.clear();
    Get.back();
  }

  void initPartial(int? tableId) {}

  void addProduct2PartialTable(int? tableId, ProductModel? product, int? oid) {
    int lastIndex = 0;
    TableModel table = tables.firstWhere((element) => element.id == tableId);

    // if ((table.partialNotPaidProducts == [] ||
    //         table.partialNotPaidProducts == null) &&
    //     (table.partialPaidProducts == [] ||
    //         table.partialPaidProducts == null)) {
    //   List<ProductListModel> productsReplicate = [];
    //   table.products!.forEach((element) {
    //     productsReplicate.add(ProductListModel.fromJson(element.toJson()));
    //   });
    //   table.partialNotPaidProducts = productsReplicate;
    //   print("init partials");
    // }

    if (tableId != null) {
      if (table.partialNotPaidProducts != null ||
          table.partialNotPaidProducts != []) {
        ProductListModel productListObj = table.partialNotPaidProducts!
            .firstWhere((element) => element.product!.id == product!.id);

        ProductListModel productListObj0 = ProductListModel(
            products: [],
            product: product,
            count: 1,
            total: (product!.price! * 1));
        productListObj0.products!.add(product);

        if (productListObj.count! > 0) {
          if (productListObj.count! == 1) {
            table.partialNotPaidProducts!.remove(productListObj);

            // If items same even its replicated
            // for (int i = 0; i < table.partialNotPaidProducts!.length; i++) {
            //   if (table.partialNotPaidProducts![i].product ==
            //           productListObj.product &&
            //       table.partialNotPaidProducts![i].count ==
            //           productListObj.count &&
            //       table.partialNotPaidProducts![i].total ==
            //           productListObj.total) {
            //     table.partialNotPaidProducts!.removeAt(i);
            //     update();
            //   }
            // }
          } else {
            // Decrise the count of the product in the partianNotPaidProducts
            ProductListModel oldProductListObjReplicate =
                ProductListModel.fromJson(productListObj.toJson());
            table.partialNotPaidProducts!.remove(productListObj);
            oldProductListObjReplicate.count =
                oldProductListObjReplicate.count! - 1;
            oldProductListObjReplicate.total =
                oldProductListObjReplicate.count! *
                    oldProductListObjReplicate.product!.price!;
            oldProductListObjReplicate.products!.removeLast();
            table.partialNotPaidProducts!.add(oldProductListObjReplicate);

            update();
          }
        }

        if (table.partialPaidProducts == null) {
          table.partialPaidProducts = [];
        }
        table.partialPaidProducts!.add(productListObj0);
        update();
        print(2);
      } else if ((table.partialPaidProducts != null ||
              table.partialPaidProducts != []) &&
          table.partialPaidProducts!
              .where((element) => element.product!.id == product!.id)
              .isNotEmpty) {
        ProductListModel productListObj = table.products!
            .firstWhere((element) => element.product!.id == product!.id);
        ProductListModel productListObjReplicate =
            ProductListModel.fromJson(productListObj.toJson());
        table.partialPaidProducts!.remove(productListObj);
        productListObjReplicate.count = productListObjReplicate.count! + 1;
        productListObjReplicate.total = productListObjReplicate.count! *
            productListObjReplicate.product!.price!;
        productListObjReplicate.products!.add(product!);
        table.partialPaidProducts!.add(productListObjReplicate);

        // Decrise the count of the product in the partianNotPaidProducts
        ProductListModel oldProductListObj = table.partialNotPaidProducts!
            .firstWhere((element) => element.product!.id == product.id);

        ProductListModel oldProductListObjReplicate =
            ProductListModel.fromJson(oldProductListObj.toJson());
        if (oldProductListObjReplicate.count! > 0) {
          if (oldProductListObjReplicate.count! == 1) {
            table.partialNotPaidProducts!.remove(oldProductListObj);
          } else {
            table.partialNotPaidProducts!.remove(oldProductListObj);
            oldProductListObjReplicate.count =
                oldProductListObjReplicate.count! - 1;
            oldProductListObjReplicate.total =
                oldProductListObjReplicate.count! *
                    oldProductListObjReplicate.product!.price!;
            oldProductListObjReplicate.products!.remove(product);
            table.partialNotPaidProducts!.add(oldProductListObjReplicate);
          }
        }

        update();

        print(1);
      }
      currentTable = table;
      update();
      calculateTotal();
      var tablesEncoded = jsonEncode(tables);
      depo.write("tables", tablesEncoded);
      update();
    }
  }

  void removeProductFromPartialTable(
      int? tableId, ProductModel? product, int? oid) {
    int lastIndex = 0;
    TableModel table = tables.firstWhere((element) => element.id == tableId);

    // if ((table.partialNotPaidProducts == [] ||
    //         table.partialNotPaidProducts == null) &&
    //     (table.partialPaidProducts == [] ||
    //         table.partialPaidProducts == null)) {
    //   List<ProductListModel> productsReplicate = [];
    //   table.products!.forEach((element) {
    //     productsReplicate.add(ProductListModel.fromJson(element.toJson()));
    //   });
    //   table.partialNotPaidProducts = productsReplicate;
    //   print("init partials");
    // }

    if (tableId != null) {
      if (table.partialPaidProducts != null ||
          table.partialPaidProducts != []) {
        ProductListModel productListObj = table.partialPaidProducts!
            .firstWhere((element) => element.product!.id == product!.id);

        ProductListModel productListObj0 = ProductListModel(
            products: [],
            product: product,
            count: 1,
            total: (product!.price! * 1));
        productListObj0.products!.add(product);

        if (productListObj.count! > 0) {
          if (productListObj.count! == 1) {
            table.partialPaidProducts!.remove(productListObj);

            // If items same even its replicated
            // for (int i = 0; i < table.partialPaidProducts!.length; i++) {
            //   if (table.partialPaidProducts![i].product ==
            //           productListObj.product &&
            //       table.partialPaidProducts![i].count == productListObj.count &&
            //       table.partialPaidProducts![i].total == productListObj.total) {
            //     table.partialPaidProducts!.removeAt(i);
            //     update();
            //   }
            // }
          } else {
            // Decrise the count of the product in the partianNotPaidProducts
            ProductListModel oldProductListObjReplicate =
                ProductListModel.fromJson(productListObj.toJson());
            table.partialPaidProducts!.remove(productListObj);
            oldProductListObjReplicate.count =
                oldProductListObjReplicate.count! - 1;
            oldProductListObjReplicate.total =
                oldProductListObjReplicate.count! *
                    oldProductListObjReplicate.product!.price!;
            oldProductListObjReplicate.products!.removeLast();
            table.partialPaidProducts!.add(oldProductListObjReplicate);

            update();
          }
        }

        if (table.partialNotPaidProducts == null) {
          table.partialNotPaidProducts = [];
        }
        table.partialNotPaidProducts!.add(productListObj0);
        update();
        print("Remove 2");
      } else if ((table.partialNotPaidProducts != null ||
              table.partialNotPaidProducts != []) &&
          table.partialNotPaidProducts!
              .where((element) => element.product!.id == product!.id)
              .isNotEmpty) {
        ProductListModel productListObj = table.products!
            .firstWhere((element) => element.product!.id == product!.id);
        ProductListModel productListObjReplicate =
            ProductListModel.fromJson(productListObj.toJson());
        table.partialNotPaidProducts!.remove(productListObj);
        productListObjReplicate.count = productListObjReplicate.count! + 1;
        productListObjReplicate.total = productListObjReplicate.count! *
            productListObjReplicate.product!.price!;
        productListObjReplicate.products!.add(product!);
        table.partialNotPaidProducts!.add(productListObjReplicate);

        // Decrise the count of the product in the partianNotPaidProducts
        ProductListModel oldProductListObj = table.partialPaidProducts!
            .firstWhere((element) => element.product!.id == product.id);

        ProductListModel oldProductListObjReplicate =
            ProductListModel.fromJson(oldProductListObj.toJson());
        if (oldProductListObjReplicate.count! > 0) {
          if (oldProductListObjReplicate.count! == 1) {
            table.partialPaidProducts!.remove(oldProductListObj);
          } else {
            table.partialPaidProducts!.remove(oldProductListObj);
            oldProductListObjReplicate.count =
                oldProductListObjReplicate.count! - 1;
            oldProductListObjReplicate.total =
                oldProductListObjReplicate.count! *
                    oldProductListObjReplicate.product!.price!;
            oldProductListObjReplicate.products!.remove(product);
            table.partialPaidProducts!.add(oldProductListObjReplicate);
          }
        }

        update();

        print("Remove 1");
      }
      currentTable = table;
      update();
      calculateTotal();
      update();
      var tablesEncoded = jsonEncode(tables);
      depo.write("tables", tablesEncoded);
      update();
    }
  }

  Future confirmPartialPayment(int? tableId, BuildContext context) async {
    int lastIndex = 0;
    TableModel table = tables.firstWhere((element) => element.id == tableId);

    if (tableId != null &&
        (table.partialPaidProducts != null ||
            table.partialPaidProducts != [])) {
      List<ProductListModel> replicateProductList = [];

      table.partialPaidProducts!.forEach((element) {
        replicateProductList.add(ProductListModel.fromJson(element.toJson()));
      });

      table.partialPaidProducts = [];
      table.partialPaidConfirmedProducts = replicateProductList;

      currentTable = table;
      update();
      calculateTotal();
      var tablesEncoded = jsonEncode(tables);
      depo.write("tables", tablesEncoded);
      update();
    }
  }
}
