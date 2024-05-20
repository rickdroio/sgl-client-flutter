//dart run build_runner build
import 'package:json_annotation/json_annotation.dart';
import 'package:sgl_app_flutter/models/base.model.dart';

part 'cidade.g.dart';

@JsonSerializable(explicitToJson: true)
class Cidade extends BaseModel {
  static List<String> ufList = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MS',
    'MT',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO',
  ];

  Cidade(this.idCidade, this.nome, this.uf, this.ibge);

  String idCidade;
  String nome;
  String uf;
  String ibge;

  factory Cidade.fromJson(Map<String, dynamic> json) => _$CidadeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CidadeToJson(this);
}
