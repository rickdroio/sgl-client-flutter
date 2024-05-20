import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStoreService {
  final storage = const FlutterSecureStorage();

  Future<String> getJwtToken() async {
    var token = await storage.read(key: 'jwt');
    //print('localStore getJwtToken = $token');
    return token != null ? token.toString() : '';
  }

  void setJwtToken(String token) {
    storage.write(key: 'jwt', value: token);
  }
}
