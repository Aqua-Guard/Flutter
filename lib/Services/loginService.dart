import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

import '../Network/networkService.dart';
import '../Screens/homeScreen.dart';
import '../Utils/constantes.dart';

class LoginService {
  Future<Response?> login(context, username, password) async {
    Map<String, Object> userObject = {
      "username": username,
      "password": password,
    };

    return await NetworkService.sendRequest(
        requestType: RequestType.post,
        url: '${Constantes.baseUrl}/login',
        body: userObject);
  }
}
