import 'package:sgl_app_flutter/services/network/httpclient.interface.dart';

abstract class BaseService {
  final IHttpClientService client;
  final String servicePath;

  BaseService({required this.client, required this.servicePath});

  Future<dynamic> getAll({int? pageSize, int? offset});

  Future updateBatch(String json);
}
