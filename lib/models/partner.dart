import 'package:json_annotation/json_annotation.dart';

part 'partner.g.dart';

@JsonSerializable()
class Partner {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'imagePath')
  final String imagePath;
  @JsonKey(name: 'categoryId')
  final String categoryId;
  @JsonKey(name: 'categoryName')
  final String categoryName;
  @JsonKey(name: 'colorClass')
  final String colorClass;
  @JsonKey(name: 'facbookLink')
  final String? facebookLink;
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'instagramLink')
  final String? instagramLink;
  @JsonKey(name: 'websiteLink')
  final String? websiteLink;
  @JsonKey(name: 'mapLink')
  final String? mapLink;
  @JsonKey(name: 'discounts')
  final List<Discount>? discounts;
  @JsonKey(name: 'largestDiscountValue')
  final double? largestDiscountValue;

  Partner({
    required this.id,
    required this.name,
    this.description,
    required this.imagePath,
    required this.categoryId,
    required this.categoryName,
    required this.colorClass,
    this.facebookLink,
    this.phoneNumber,
    this.instagramLink,
    this.websiteLink,
    this.mapLink,
    this.discounts,
    this.largestDiscountValue,
  });

  factory Partner.fromJson(Map<String, dynamic> json) => _$PartnerFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerToJson(this);
}

@JsonSerializable()
class Discount {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'dueDate')
  final String? dueDate;
  @JsonKey(name: 'value')
  final double? value;
  @JsonKey(name: 'imagePath')
  final String? imagePath;

  Discount({
    required this.id,
    required this.name,
    required this.description,
    this.dueDate,
    this.value,
    this.imagePath,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => _$DiscountFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountToJson(this);
}
