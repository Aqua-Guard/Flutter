import 'package:aquaguard/Models/actualite.dart';
import 'package:aquaguard/Models/discution.dart';
import 'package:aquaguard/Models/reclamation.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;


class ReclamationWebService{

Future<List<Reclamation>> fetchReclamation(String token) async {
  final response = await http.get(Uri.parse(Constantes.urlReclamation+"/get"),
      headers: {
        'Authorization': 'Bearer $token',
      },);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Reclamation.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load reclamation');
  }
}



Future<List<Discution>> fetchDisction(String token, String idreclamation) async {
  final response = await http.post(
    Uri.parse('${Constantes.urlReclamation}/getdiscution/$idreclamation'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Discution.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load discution');
  }
}


 Future<void> sendMessageAdmin(String token, String reclamationId, String message) async {
    final response = await http.post(
      Uri.parse('${Constantes.urlDiscution}/sendmessageadmin'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'reclamationId': reclamationId,
        'message': message,
      },
    );

    if (response.statusCode == 200) {
      // Handle successful response if needed
    } else {
      throw Exception('Failed to send message');
    }
  }

 

  }

 






   
