//dart run build_runner build
import 'package:json_annotation/json_annotation.dart';
import 'package:sgl_app_flutter/models/base.model.dart';

part 'cor.g.dart';

@JsonSerializable(explicitToJson: true)
class Cor extends BaseModel {
  Cor(this.nome, this.sigla, this.code);

  String nome;
  String sigla;
  String? code;

  factory Cor.fromJson(Map<String, dynamic> json) => _$CorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CorToJson(this);
}
