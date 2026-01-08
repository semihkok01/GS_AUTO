import 'package:flutter/foundation.dart';

class ExtraModel {
  String? category;
  String? content;
  bool? status;
  double? price;

  ExtraModel({this.category, this.content, this.status, this.price});

  @override
  String toString() =>
      'ExtraModel(category: $category, content: $content, status: $status, price: $price)';

  factory ExtraModel.fromJson(Map<String, dynamic> json) => ExtraModel(
        category: json['category'] as String?,
        content: json['content'] as String?,
        status: json['status'] as bool?,
        price: json['price'] as double?,
      );

  Map<String, dynamic> toJson() => {
        'category': category,
        'content': content,
        'status': status,
        'price': price,
      };

  ExtraModel copyWith({
    String? category,
    String? content,
    bool? status,
    double? price,
  }) {
    return ExtraModel(
      category: category ?? this.category,
      content: content ?? this.content,
      status: status ?? this.status,
      price: price ?? this.price,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (identical(other, this)) return true;
    if (other is! ExtraModel) return false;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      category.hashCode ^ content.hashCode ^ status.hashCode ^ price.hashCode;
}
