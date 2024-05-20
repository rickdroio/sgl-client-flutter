import 'package:sgl_app_flutter/models/cor.dart';
import 'package:sgl_app_flutter/services/base.service.dart';

class CoresService extends BaseService {
  CoresService({required super.client, required super.servicePath});

  @override
  Future<List<Cor>> getAll({int? pageSize, int? offset}) async {
    var url = '$servicePath?';
    if (pageSize != null) url += 'take=$pageSize';
    if (offset != null) url += 'skip=$offset';

    var response = await client.get(url);
    List<Cor> items = response == null
        ? []
        : (response as List).map((item) => Cor.fromJson(item)).toList();
    return items;
  }

  Future<List<Cor>> getAllFiltered(String filter) async {
    var response = await client.get('$servicePath/search?query=$filter');
    List<Cor> items =
        (response as List).map((item) => Cor.fromJson(item)).toList();
    return items;
  }

  @override
  Future updateBatch(String json) {
    print('updateBatch = $json');
    //var json = JsonHelper.modelToJson<Cidade>(items);
    return client.post('$servicePath/batch', data: json);
  }
}
