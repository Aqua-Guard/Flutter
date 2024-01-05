import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

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
        url: '${Constantes.baseUrl}/loginFlutter',
        body: userObject);
  }


  Future<Response?> signUp({
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required html.File image,
  }) async {
    var uri = Uri.parse('${Constantes.baseUrl}/registerFlutter');
    var request = http.MultipartRequest('POST', uri);

    request.fields['username'] = username;
    request.fields['email'] = email;
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['password'] = password;

    Uint8List imageBytes = await _readFileBytes(image);

    var multipartFile = http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: image.name,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);

    var response = await request.send();
    return http.Response.fromStream(response);
  }

  Future<Response?> updateProfile({
    required String id,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required html.File image,
  }) async {
    var uri = Uri.parse('${Constantes.baseUrl}/updateProfile/${id}');
    var request = http.MultipartRequest('PUT', uri);

    request.fields['newUsername'] = username;
    request.fields['email'] = email;
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;

    Uint8List imageBytes = await _readFileBytes(image);

    var multipartFile = http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: image.name,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);

    var response = await request.send();
    return http.Response.fromStream(response);
  }



  Future<Uint8List> _readFileBytes(html.File file) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoad.first;
    return reader.result as Uint8List;
  }
}
