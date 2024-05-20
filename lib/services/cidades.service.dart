import 'dart:convert';

import 'package:sgl_app_flutter/components/helper/json.helper.dart';
import 'package:sgl_app_flutter/models/cidade.dart';
import 'package:sgl_app_flutter/services/base.service.dart';

class CidadesService extends BaseService {
  CidadesService({required super.client, required super.servicePath});

  @override
  Future<List<Cidade>> getAll({int? pageSize, int? offset}) async {
    var url = '$servicePath?';
    if (pageSize != null) url += 'pageSize=$pageSize';
    if (offset != null) url += 'offset=$offset';

    var response = await client.get(url);

    print(response["content"]);

    List<Cidade> items = (response["content"] as List)
        .map((item) => Cidade.fromJson(item))
        .toList();
    return items;
  }

  Future<List<Cidade>> getAllFiltered(String filter) async {
    var response = await client.get('$servicePath/search?query=$filter');
    List<Cidade> items =
        (response as List).map((item) => Cidade.fromJson(item)).toList();
    return items;
  }

  @override
  Future updateBatch(String json) {
    print('updateBatch = $json');
    //var json = JsonHelper.modelToJson<Cidade>(items);
    return client.post('$servicePath/batch', data: json);
  }
}
