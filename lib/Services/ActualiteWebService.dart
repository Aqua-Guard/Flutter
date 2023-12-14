import 'package:aquaguard/Models/actualite.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ActualiteWebService{

Future<List<Actualite>> fetchActualite() async {
  final response = await http.get(Uri.parse(Constantes.urlActualite));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Actualite.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load actualite');
  }
}
}