import 'package:pos_order_basic/app/modules/products/models/extra_model.dart';
import 'package:uuid/uuid.dart';

class ProductModel {
  String uuid = Uuid().v4();
  int? id;
  String? category;
  String? name;
  double? price;
  bool? hasExtra;
  List<ExtraModel>? extras;
  bool? returned = false;
  bool? wentToKitchen = false;
  int? printerId;

  ProductModel(
      {this.id,
      this.category,
      this.name,
      this.price,
      this.hasExtra,
      this.extras,
      this.returned,
      this.wentToKitchen,
      this.printerId});

  @override
  String toString() {
    return 'ProductModel(uuid: $uuid, id: $id, kategori: $category, name: $name, price: $price, hasExtra: $hasExtra, extras: $extras, returned: $returned, wentToKitchen: $wentToKitchen, printerId: $printerId)';
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        category: json['category'] as String?,
        name: json['name'] as String?,
        price: json['price'] as double?,
        hasExtra: json['hasExtra'] as bool?,
        extras: json['extras'] == null
            ? null
            : List<ExtraModel>.from(
                json['extras']?.map((x) => ExtraModel.fromJson(x))),
        returned: json['returned'] as bool?,
        wentToKitchen: json['wentToKitchen'] as bool?,
        printerId: json['printerId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        'category': category,
        'name': name,
        'price': price,
        'hasExtra': hasExtra,
        'extras': extras == null
            ? null
            : List<dynamic>.from(extras!.map((x) => x.toJson())),
        'returned': returned,
        'wentToKitchen': wentToKitchen,
        'printerId': printerId,
      };

  ProductModel copyWith({
    int? id,
    String? category,
    String? name,
    double? price,
    bool? hasExtra,
    List<ExtraModel>? extras,
    bool? returned,
    bool? wentToKitchen,
    int? printerId,
  }) {
    return ProductModel(
      id: id ?? this.id,
      category: category ?? this.category,
      name: name ?? this.name,
      price: price ?? this.price,
      hasExtra: hasExtra ?? this.hasExtra,
      extras: extras ?? this.extras,
      returned: returned ?? this.returned,
      wentToKitchen: wentToKitchen ?? this.wentToKitchen,
      printerId: printerId ?? this.printerId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductModel &&
        id == other.id &&
        other.category == category &&
        other.name == name &&
        other.price == price &&
        other.hasExtra == hasExtra &&
        other.extras == extras &&
        other.returned == returned
        //&& other.wentToKitchen == wentToKitchen
        &&
        other.printerId == printerId;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      category.hashCode ^
      name.hashCode ^
      price.hashCode ^
      hasExtra.hashCode ^
      extras.hashCode ^
      returned.hashCode ^
      wentToKitchen.hashCode ^
      printerId.hashCode;
}
