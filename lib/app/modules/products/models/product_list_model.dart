import 'package:flutter/foundation.dart';
import 'package:pos_order_basic/app/modules/products/models/product_model.dart';

class ProductListModel {
  ProductModel? product;
  List<ProductModel>? products;
  int? count;
  double? total;

  ProductListModel({this.product, this.products, this.count, this.total});

  @override
  String toString() =>
      'ProductListModel(product: $product, products: $products,count: $count, total: $total)';

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      product: json['product'] as ProductModel,
      products: json['products'] == null
          ? null
          : List<ProductModel>.from(
              json['products']?.map((x) => ProductModel.fromJson(x.toJson()))),
      count: json['count'] as int?,
      total: json['total'] as double?,
    );
  }

  Map<String, dynamic> toJson() => {
        'product': product,
        'products': products,
        'count': count,
        'total': total,
      };

  ProductListModel copyWith({
    ProductModel? product,
    List<ProductModel>? products,
    int? count,
    double? total,
  }) {
    return ProductListModel(
        product: product ?? this.product,
        products: products ?? this.products,
        count: count ?? this.count,
        total: total ?? this.total);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductListModel &&
        runtimeType == other.runtimeType &&
        product == other.product &&
        listEquals(products, other.products) &&
        count == other.count &&
        total == other.total;
  }

  @override
  int get hashCode =>
      product.hashCode ^ products.hashCode ^ count.hashCode ^ total.hashCode;
}
