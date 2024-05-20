// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cidade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cidade _$CidadeFromJson(Map<String, dynamic> json) => Cidade(
      json['idCidade'] as String,
      json['nome'] as String,
      json['uf'] as String,
      json['ibge'] as String,
    )..tenantId = (json['tenantId'] as num).toInt();

Map<String, dynamic> _$CidadeToJson(Cidade instance) => <String, dynamic>{
      'tenantId': instance.tenantId,
      'idCidade': instance.idCidade,
      'nome': instance.nome,
      'uf': instance.uf,
      'ibge': instance.ibge,
    };
