import 'package:json_annotation/json_annotation.dart';

abstract class BaseModel {
  @JsonKey(defaultValue: 0, includeFromJson: true, includeToJson: true)
  int id = 0;

  @JsonKey(includeFromJson: true, includeToJson: true)
  int tenantId = 0;

  //@JsonKey(defaultValue: false, includeFromJson: true, includeToJson: true)
  //bool isEdited = false;

  Map<String, dynamic> toJson();
  //fromJson(Map<String, dynamic> json);
}
