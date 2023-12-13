import 'package:aquaguard/Models/post.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostWebService {
  
  Future<List<Post>> getAllPosts(String token) async {
  final response = await http.get(Uri.parse(Constantes.urlPost+'/getAdmin'),
 
  headers:  {
        'Authorization': 'Bearer $token',
        
      },);

  if (response.statusCode == 200) {
    
    List<dynamic> data = json.decode(response.body);
    data.map((json) => Post.fromJson(json)).toList();
    
    return data.map((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Post web service');
  }
}

}