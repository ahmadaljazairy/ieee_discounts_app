import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  final String? id;
  final String? name;
  final String? imagePath;

  Member({
    this.id,
    this.name,
    this.imagePath,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
