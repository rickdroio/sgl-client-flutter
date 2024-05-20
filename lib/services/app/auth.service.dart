import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sgl_app_flutter/services/app/localstore.service.dart';
import 'package:sgl_app_flutter/services/network/httpclient.interface.dart';

class AuthService with ChangeNotifier {
  final IHttpClientService client;
  final LocalStoreService localStore;

  AuthService(this.client, this.localStore);

  bool isLogged = false;
  String jwtToken = '';

  void logOut() {
    isLogged = false;
    notifyListeners();
  }

  Future checkLoginStatus() async {
    print('checkLoginStatus');
    var token = await localStore.getJwtToken();

    isLogged = token.isNotEmpty;
    notifyListeners();
  }

  void login(String email, String password) async {
    //AUTH BASIC
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$email:$password'))}';
    Options options = Options(headers: {'authorization': basicAuth});

    var response = await client.post('/auth',
        data: {'email': email, 'password': password}, options: options);

    if (response != null && response.toString().isNotEmpty) {
      _registerToken(response.toString());
    }
  }

  void _registerToken(String token) async {
    isLogged = true;
    jwtToken = token;
    notifyListeners();

    //Token is cached
    localStore.setJwtToken(token);
  }
}
