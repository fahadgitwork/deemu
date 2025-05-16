import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final Map<String, dynamic> name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  String get displayName => name['name'] as String;

  // Helper constructor for string-based creation
  factory Category.fromString(String name) =>
      Category(name: {'name': name, 'slug': name.toLowerCase(), 'url': ''});
}
