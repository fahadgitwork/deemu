import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductResponse {
  final List<Product> products;
  final int total;

  ProductResponse({required this.products, required this.total});

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class Product {
  final int id;
  final String title;
  final String? category;
  @JsonKey(fromJson: _priceFromJson)
  final double price;
  @JsonKey(fromJson: _ratingFromJson)
  final double rating;
  final String? brand;
  @JsonKey(defaultValue: [])
  final List<String> images;
  final String? description;
  final int stock;

  Product({
    required this.id,
    required this.title,
    this.category,
    required this.price,
    required this.rating,
    this.brand,
    required this.images,
    this.description,
    required this.stock,
  });

  static double _priceFromJson(dynamic value) {
    if (value == null) return 0.0;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    if (value is double) return value;
    return 0.0;
  }

  static double _ratingFromJson(dynamic value) {
    if (value == null) return 0.0;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    if (value is double) return value;
    return 0.0;
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
