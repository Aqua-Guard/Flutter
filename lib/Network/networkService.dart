import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../Utils/constantes.dart';

enum RequestType { get, put, post, delete }

const storage = FlutterSecureStorage();
Future<String?> bearer = storage.read(key: "token");

class NetworkService {

  static Map<String, String> _getHeaders() => {
    'Content-Type': 'application/json',
  };

  static Future<http.Response?>? _createRequest({
    required RequestType requestType,
    required Uri uri,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    String? token = await storage.read(key: "token");
    if (requestType == RequestType.get) {
      return http.get(uri, headers: {'Authorization': 'Bearer ${token ?? ""}'});
    } else if (requestType == RequestType.post) {
      return http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${token ?? ""}'
          },
          body: jsonEncode(body));
    } else if (requestType == RequestType.put) {
      return http.put(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${token ?? ""}'
          },
          body: jsonEncode(body));
    }
    else if (requestType == RequestType.delete) {
      return http.delete(uri);
    }
    return null;
  }

  static String concatUrlQP(String url, Map<String, String>? queryParameters) {
    if (url.isEmpty) return url;
    if (queryParameters == null || queryParameters.isEmpty) {
      return url;
    }
    final StringBuffer stringBuffer = StringBuffer("$url?");
    queryParameters.forEach((key, value) {
      if (value.trim() == '') return;
      if (value.contains(' ')) throw Exception('Invalid Input Exception');
      stringBuffer.write('$key=$value&');
    });
    final result = stringBuffer.toString();
    return result.substring(0, result.length - 1);
  }

  static Future<http.Response?>? sendRequest({
    required RequestType requestType,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? queryParam,
  }) async {
    try {
      final _header = _getHeaders();
      final _url = concatUrlQP(url, queryParam);
      final response = await _createRequest(
        requestType: requestType,
        uri: Uri.parse(_url),
        headers: _header,
        body: body,
      );
      debugPrint(response?.body);
      return response;
    } catch (e) {
      print('Error - $e');
      return null;
    }
  }

}
