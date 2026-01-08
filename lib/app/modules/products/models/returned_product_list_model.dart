import 'package:flutter/foundation.dart';
import 'package:pos_order_basic/app/modules/products/models/product_model.dart';

class ReturnedProductListModel {
  ProductModel? product;
  List<ProductModel>? products;
  int? count;
  DateTime? date;
  String? billNumber;
  String? tableNumber;
  double? total;

  ReturnedProductListModel(
      {this.product,
      this.products,
      this.count,
      this.date,
      this.billNumber,
      this.tableNumber,
      this.total});

  @override
  String toString() =>
      'ProductListModel(product: $product, products: $products,count: $count, ,date: $date, billNumber: $billNumber, tableNumber: $tableNumber, total: $total)';

  factory ReturnedProductListModel.fromJson(Map<String, dynamic> json) {
    return ReturnedProductListModel(
      product: json['product'] as ProductModel,
      products: json['products'] == null
          ? null
          : List<ProductModel>.from(
              json['products']?.map((x) => ProductModel.fromJson(x.toJson()))),
      count: json['count'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      billNumber: json['billNumber'] as String,
      tableNumber: json['tableNumber'] as String,
      total: json['total'] as double?,
    );
  }

  Map<String, dynamic> toJson() => {
        'product': product,
        'products': products,
        'count': count,
        'date': date?.toIso8601String(),
        'billNumber': billNumber,
        'total': total,
      };

  ReturnedProductListModel copyWith({
    ProductModel? product,
    List<ProductModel>? products,
    int? count,
    DateTime? date,
    String? billNumber,
    String? tableNumber,
    double? total,
  }) {
    return ReturnedProductListModel(
        product: product ?? this.product,
        products: products ?? this.products,
        count: count ?? this.count,
        date: date ?? this.date,
        billNumber: billNumber ?? this.billNumber,
        total: total ?? this.total);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReturnedProductListModel &&
        runtimeType == other.runtimeType &&
        product == other.product &&
        listEquals(products, other.products) &&
        count == other.count &&
        date == other.date &&
        billNumber == other.billNumber &&
        tableNumber == other.tableNumber &&
        total == other.total;
  }

  @override
  int get hashCode =>
      product.hashCode ^
      products.hashCode ^
      count.hashCode ^
      date.hashCode ^
      billNumber.hashCode ^
      tableNumber.hashCode ^
      total.hashCode;
}
