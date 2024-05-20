import 'package:get_it/get_it.dart';
import 'package:sgl_app_flutter/services/app/app_router.dart';
import 'package:sgl_app_flutter/services/app/auth.service.dart';
import 'package:sgl_app_flutter/services/app/localstore.service.dart';
import 'package:sgl_app_flutter/services/cidades.service.dart';
import 'package:sgl_app_flutter/services/cores.service.dart';
import 'package:sgl_app_flutter/services/network/diohttpclient.service.dart';
import 'package:sgl_app_flutter/services/network/httpclient.interface.dart';

void setupGetit() {
  GetIt.I.registerSingleton<LocalStoreService>(LocalStoreService());
  GetIt.I
      .registerSingleton<IHttpClientService>(DioHttpClientService(GetIt.I()));

  GetIt.I.registerSingleton<AuthService>(AuthService(GetIt.I(), GetIt.I()));
  GetIt.I.registerSingleton<AppRouter>(AppRouter(GetIt.I()));

  GetIt.I.registerFactory(
      () => CidadesService(servicePath: '/cidades', client: GetIt.I()));
  GetIt.I.registerFactory(
      () => CoresService(servicePath: '/cores', client: GetIt.I()));
}
