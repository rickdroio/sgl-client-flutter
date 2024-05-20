import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sgl_app_flutter/components/message_alert.dart';
import 'package:sgl_app_flutter/services/app/localstore.service.dart';
import 'package:sgl_app_flutter/services/network/httpclient.interface.dart';

class DioHttpClientService extends IHttpClientService {
  LocalStoreService localStore;

  static Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    //AUTHORIZATION: TOKEN,
  };

  static BaseOptions options = BaseOptions(
    headers: headers,
    baseUrl: 'http://localhost:8080',
    responseType: ResponseType.json,
    connectTimeout: const Duration(milliseconds: 3000),
    receiveTimeout: const Duration(milliseconds: 3000),
  );

  final dio = Dio(options);

  DioHttpClientService(this.localStore) {
    _setupToken();
  }

  _setupToken() async {
    var token = await localStore.getJwtToken();
    //print('interceptor before = ${token}');
    if (token.isNotEmpty) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            print('interceptor = ${token}');
            options.headers["Authorization"] = "Bearer ${token}";
            return handler.next(options);
          },
/*           onError: (DioError e, handler) async {
            if (e.response?.statusCode == 401) {
              // If a 401 response is received, refresh the access token
              String newAccessToken = await refreshToken();

              // Update the request header with the new access token
              e.requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';

              // Repeat the request with the updated header
              return handler.resolve(await dio.fetch(e.requestOptions));
            }
            return handler.next(e);
          }, */
        ),
      );
    }
  }

  _processResponse(Response response, {bool showMessage = false}) {
    print('_processResponse = ${response.statusCode} = ${response.data}');

    switch (response.statusCode) {
      case 200 || 201:
        if (showMessage) {
          MessageAlert().showMessage('Atualizado com sucesso!');
        }

        if (response.data.isNotEmpty) {
          //ja vem convertido do DIO
          return response.data;
        } else {
          return null;
        }
    }
  }

  @override
  Future delete(String url) {
    try {
      return dio.delete(url);
    } on DioException catch (e) {
      throw DioHttpClientExceptionHandle.handleError(e);
    }
  }

  @override
  Future get(String url) async {
    print('DIO GET $url');
    try {
      var response = await dio.get(url);
      return _processResponse(response);
    } on DioException catch (e) {
      throw DioHttpClientExceptionHandle.handleError(e);
    }
  }

  @override
  Future patch(String url, {data}) async {
    try {
      print('DIO PATCH $url $data');
      var response = await dio.patch(url, data: data);
      return response;
    } on DioException catch (e) {
      throw DioHttpClientExceptionHandle.handleError(e);
    }
  }

  @override
  Future post(String url, {dynamic data, dynamic options}) async {
    print('DIO POST $url $data');
    try {
      var response = await dio.post(url, data: data, options: options);
      return _processResponse(response, showMessage: true);
    } on DioException catch (e) {
      print(e);
      throw DioHttpClientExceptionHandle.handleError(e);
    }
  }

  @override
  Future put(String url, {data}) {
    return dio.put(url, data: data);
  }
}

abstract class DioHttpClientExceptionHandle {
  static String _traducao(String mensagem) {
    return mensagem.replaceAll('should not be empty', 'não pode ser vazio');
  }

  static String _getError(dynamic response) {
    String errorMessage = '';

    if (response['message'] is List<dynamic>) {
      List<dynamic> listaError = (response['message'] as List<dynamic>);
      for (var i = 0; i < listaError.length; i++) {
        if (errorMessage != '') errorMessage += '\n';
        errorMessage += '${_traducao(listaError[i].toString())}';
      }
    }

    return errorMessage;
  }

  static handleError(DioException e) {
    print('handleError DioException');
    print(e);
    String errorMessage;
    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 401:
          errorMessage = 'Não autorizado';
          break;
        case 400:
          errorMessage = _getError(e.response!.data);
          break;
        default:
          errorMessage = 'Erro desconhecido ${e.response}';
      }
    } else if (e.type == DioExceptionType.connectionError) {
      errorMessage = 'Erro de conexão';
    } else {
      errorMessage = e.message ?? '';
    }

    MessageAlert().showMessage(errorMessage);
    return e;
  }
}
