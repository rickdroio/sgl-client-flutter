// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cor _$CorFromJson(Map<String, dynamic> json) => Cor(
      json['nome'] as String,
      json['sigla'] as String,
      json['code'] as String?,
    )
      ..id = (json['id'] as num?)?.toInt() ?? 0
      ..tenantId = (json['tenantId'] as num).toInt();

Map<String, dynamic> _$CorToJson(Cor instance) => <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'nome': instance.nome,
      'sigla': instance.sigla,
      'code': instance.code,
    };
