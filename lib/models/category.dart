import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final String id;
  final String name;

  const Category({required this.id, required this.name});

  // Factory for deserialization (generated code will handle this)
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  // Method for serialization (generated code will handle this)
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
