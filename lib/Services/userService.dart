import 'dart:convert';

import 'package:aquaguard/Utils/constantes.dart';
import 'package:http/http.dart';

import '../Models/userResponse.dart';
import '../Network/networkService.dart';

class UserService{

  Future<List<UserResponse>> fetchUsers() async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get, url: "${Constantes.baseUrl}/getUsers");

    if (response?.statusCode == 200) {
      List<dynamic> data = json.decode(response!.body);
      return data.map((json) => UserResponse.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<Response?> deleteUser(String id) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.delete,
        url: "${Constantes.baseUrl}/deleteUserById/$id");
    return response;
  }
}