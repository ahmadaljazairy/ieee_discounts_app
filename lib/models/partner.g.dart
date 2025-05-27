// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Partner _$PartnerFromJson(Map<String, dynamic> json) => Partner(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      imagePath: json['imagePath'] as String,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      colorClass: json['colorClass'] as String,
      facebookLink: json['facbookLink'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      instagramLink: json['instagramLink'] as String?,
      websiteLink: json['websiteLink'] as String?,
      mapLink: json['mapLink'] as String?,
      discounts: (json['discounts'] as List<dynamic>?)
          ?.map((e) => Discount.fromJson(e as Map<String, dynamic>))
          .toList(),
      largestDiscountValue: (json['largestDiscountValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PartnerToJson(Partner instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'colorClass': instance.colorClass,
      'facbookLink': instance.facebookLink,
      'phoneNumber': instance.phoneNumber,
      'instagramLink': instance.instagramLink,
      'websiteLink': instance.websiteLink,
      'mapLink': instance.mapLink,
      'discounts': instance.discounts,
      'largestDiscountValue': instance.largestDiscountValue,
    };

Discount _$DiscountFromJson(Map<String, dynamic> json) => Discount(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      dueDate: json['dueDate'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      imagePath: json['imagePath'] as String?,
    );

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'dueDate': instance.dueDate,
      'value': instance.value,
      'imagePath': instance.imagePath,
    };
