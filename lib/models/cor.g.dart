// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cor _$CorFromJson(Map<String, dynamic> json) => Cor(
      json['idCor'] as String,
      json['nome'] as String,
      json['sigla'] as String,
      json['code'] as String?,
    )..tenantId = (json['tenantId'] as num).toInt();

Map<String, dynamic> _$CorToJson(Cor instance) => <String, dynamic>{
      'tenantId': instance.tenantId,
      'idCor': instance.idCor,
      'nome': instance.nome,
      'sigla': instance.sigla,
      'code': instance.code,
    };
