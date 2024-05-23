// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cidade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cidade _$CidadeFromJson(Map<String, dynamic> json) => Cidade(
      json['nome'] as String,
      json['uf'] as String,
      json['ibge'] as String,
    )
      ..id = (json['id'] as num?)?.toInt() ?? 0
      ..tenantId = (json['tenantId'] as num).toInt();

Map<String, dynamic> _$CidadeToJson(Cidade instance) => <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'nome': instance.nome,
      'uf': instance.uf,
      'ibge': instance.ibge,
    };
