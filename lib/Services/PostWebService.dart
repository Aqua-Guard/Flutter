import 'dart:html' as html;
import 'dart:typed_data';


import 'package:aquaguard/Models/post.dart';
import 'package:aquaguard/Models/postCount.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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

Future<void> deletePost(String token,String postId) async {
  final url = Uri.parse('${Constantes.urlPost}/$postId');
  try {
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Success
      print('Post deleted successfully');
    } else {
      // Error
      print('Failed to delete Post. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    // Exception
    print('Error: $error');
  }
}



Future<bool> addPost(String token, String description, html.File imageFile) async {
  var uri = Uri.parse('http://localhost:9090/posts/');
  var request = http.MultipartRequest('POST', uri)
    ..headers.addAll({
      'Authorization': 'Bearer $token',
      // Don't set Content-Type here, it's set automatically
    })
    ..fields['description'] = description;

  // Read the image file as bytes
  Uint8List fileBytes = await _readFileBytes(imageFile);
  var multipartFile = http.MultipartFile.fromBytes(
    'image',
    fileBytes,
    filename: imageFile.name,
    contentType: MediaType('image', 'jpeg'),
  );
  request.files.add(multipartFile);

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add post');
    }
  } catch (e) {
    throw Exception('Error adding post: $e');
  }
}

Future<Uint8List> _readFileBytes(html.File file) async {
  final reader = html.FileReader();
  reader.readAsArrayBuffer(file);
  await reader.onLoad.first;
  return reader.result as Uint8List;
}

Future<List<PostCount>> getPostsPerWeek(String token) async {
  final response = await http.get(
    Uri.parse('${Constantes.urlPost}/PostPerWeekstat'), // Replace with your actual endpoint
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => PostCount.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts per week');
  }
}

}