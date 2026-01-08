import 'package:flutter/foundation.dart';
import 'package:pos_order_basic/app/modules/products/models/product_list_model.dart';
import 'package:pos_order_basic/app/modules/products/models/returned_product_list_model.dart';

class TableModel {
  int? id;
  String? name;
  List<ProductListModel>? products;
  List<ProductListModel>? removedProducts;
  List<ReturnedProductListModel>? returnedProducts;
  List<ProductListModel>? partialPaidProducts;
  List<ProductListModel>? partialNotPaidProducts;
  List<ProductListModel>? partialPaidConfirmedProducts;
  double? total;
  double? totalPaid;
  double? totalNotPaid;
  double? totalWillPay;
  String? note;

  TableModel(
      {this.id,
      this.name,
      this.products,
      this.removedProducts,
      this.returnedProducts,
      this.partialPaidProducts,
      this.partialNotPaidProducts,
      this.partialPaidConfirmedProducts,
      this.total,
      this.totalPaid,
      this.totalNotPaid,
      this.totalWillPay,
      this.note});

  @override
  String toString() =>
      'Table(name: $name, products: $products, removedProducts: $removedProducts, returnedProducts: $returnedProducts, total: $total, note: $note)';

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        products: json['products'] as List<ProductListModel>?,
        removedProducts: json['removedProducts'] as List<ProductListModel>?,
        returnedProducts:
            json['returnedProducts'] as List<ReturnedProductListModel>?,
        partialPaidProducts:
            json['partialPaidProducts'] as List<ProductListModel>?,
        partialNotPaidProducts:
            json['partialNotPaidProducts'] as List<ProductListModel>?,
        partialPaidConfirmedProducts:
            json['partialPaidConfirmedProducts'] as List<ProductListModel>?,
        total: json['total'] as double?,
        totalPaid: json['totalPaid'] as double?,
        totalNotPaid: json['totalNotPaid'] as double?,
        totalWillPay: json['totalWillPay'] as double?,
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'products': products,
        'removedProducts': removedProducts,
        'returnedProducts': returnedProducts,
        'partialPaidProducts': partialPaidProducts,
        'partialNotPaidProducts': partialNotPaidProducts,
        'partialPaidConfirmedProducts': partialPaidConfirmedProducts,
        'total': total,
        'totalPaid': totalPaid,
        'totalNotPaid': totalNotPaid,
        'totalWillPay': totalWillPay,
        'note': note,
      };

  TableModel copyWith({
    int? id,
    String? name,
    List<ProductListModel>? products,
    List<ProductListModel>? removedProducts,
    List<ReturnedProductListModel>? returnedProducts,
    List<ProductListModel>? partialPaidProducts,
    List<ProductListModel>? partialNotPaidProducts,
    List<ProductListModel>? partialPaidConfirmedProducts,
    double? total,
    double? totalPaid,
    double? totalNotPaid,
    double? totalWillPay,
    String? note,
  }) {
    return TableModel(
      id: id ?? this.id,
      name: name ?? this.name,
      products: products ?? this.products,
      removedProducts: removedProducts ?? this.removedProducts,
      returnedProducts: returnedProducts ?? this.returnedProducts,
      partialPaidProducts: partialPaidProducts ?? this.partialPaidProducts,
      partialNotPaidProducts:
          partialNotPaidProducts ?? this.partialNotPaidProducts,
      partialPaidConfirmedProducts:
          partialPaidConfirmedProducts ?? this.partialPaidConfirmedProducts,
      total: total ?? this.total,
      totalPaid: totalPaid ?? this.totalPaid,
      totalNotPaid: totalNotPaid ?? this.totalNotPaid,
      totalWillPay: totalWillPay ?? this.totalWillPay,
      note: note ?? this.note,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TableModel &&
        id == other.id &&
        name == other.name &&
        listEquals(other.products, products) &&
        listEquals(other.removedProducts, removedProducts) &&
        listEquals(other.returnedProducts, returnedProducts) &&
        listEquals(other.partialPaidProducts, partialPaidProducts) &&
        listEquals(other.partialNotPaidProducts, partialNotPaidProducts) &&
        listEquals(
            other.partialPaidConfirmedProducts, partialPaidConfirmedProducts) &&
        total == other.total &&
        totalPaid == other.totalPaid &&
        totalNotPaid == other.totalNotPaid &&
        totalWillPay == other.totalWillPay &&
        note == other.note;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      products.hashCode ^
      removedProducts.hashCode ^
      returnedProducts.hashCode ^
      partialPaidProducts.hashCode ^
      partialNotPaidProducts.hashCode ^
      partialPaidConfirmedProducts.hashCode ^
      total.hashCode ^
      totalPaid.hashCode ^
      totalNotPaid.hashCode ^
      totalWillPay.hashCode ^
      note.hashCode;
}
