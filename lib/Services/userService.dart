import 'dart:convert';

import 'package:aquaguard/Utils/constantes.dart';
import 'package:http/http.dart';

import '../Models/userResponse.dart';
import '../Network/networkService.dart';

class UserService{

  Future<List<UserResponse>> fetchUsers(String id) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get, url: "${Constantes.baseUrl}/getUsers/$id");

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

  Future<Response?> sendCode(String email) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.post,
        url: "${Constantes.baseUrl}/sendActivationCode",
        body: {"email": email});
    return response;
  }

  Future<Response?> verifyCode(String email, String code) async {
    print("code-----------"+ code);
    final response = await NetworkService.sendRequest(
        requestType: RequestType.post,
        url: "${Constantes.baseUrl}/verifyCode",
        body: {"email": email, "resetCode": code});
    return response;
  }

  Future<Response?> forgotPassword(String email,String password, String confirmPassword) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.post,
        url: "${Constantes.baseUrl}/forgotPassword",
        body: {"email": email, "newPassword": password, "confirmPassword": confirmPassword});
    return response;
  }
}