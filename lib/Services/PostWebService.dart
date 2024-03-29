
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
  var uri = Uri.parse('${Constantes.urlPost}/');
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

Future<String?> generatePostDescriptionWithChatGPT(String promptString, String token) async {
  try {
    // Assuming the prompt is the event name
    String prompt = promptString;

    // Make a GET request to the endpoint
    final response = await http.get(
      Uri.parse(Constantes.urlPost+'/generateDescriptionWithChat/$prompt'),
       headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      String generatedDescription = data['description'];
      return generatedDescription;
    } else {
      throw Exception('Failed to generate description with ChatGPT');
    }
  } catch (error) {
    print('Error generating description with ChatGPT: $error');
    return null;
  }
}


Future<bool?> detectDiscriminationInText(String promptString, String token) async {
  try {
    // Assuming the prompt is the event name
    String prompt = promptString;

    // Make a GET request to the endpoint
    final response = await http.get(
      Uri.parse(Constantes.urlPost+'/detectDiscrimination/$prompt'),
       headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // convert this "true" to "false" to boolean
     if (data['analysis']?.toLowerCase() == 'true' ) {
      return true;  
     }else{
      return false;  
     }
 //Error generating description with ChatGPT: Expected a value of type 'bool', but got one of type 'String'
      
    } else {
      throw Exception('Failed to detect Discrimination with ChatGPT');
    }
  } catch (error) {
    print('Error generating description with ChatGPT: $error');
    return null;
  }
}
Future<bool?> detectDiscriminationInPost(String postId, String token) async {
  try {
    // Assuming the prompt is the event name
    String postid = postId;

    // Make a GET request to the endpoint
    final response = await http.get(
      Uri.parse(Constantes.urlPost+'/detectDiscriminationPostAdmin/$postid'),
       headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // convert this "true" to "false" to boolean
     if (data['analysis']?.toLowerCase() == 'true' ) {
      return true;  
     }else{
      return false;  
     }
 //Error generating description with ChatGPT: Expected a value of type 'bool', but got one of type 'String'
      
    } else {
      throw Exception('Failed to detect Discrimination with ChatGPT');
    }
  } catch (error) {
    print('Error generating description with ChatGPT: $error');
    return null;
  }
}



Future<void> deleteComment(String token,String commentId ) async {
  final url = Uri.parse('${Constantes.urlComment}/admin/$commentId');
  try {
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Success
      print('comment deleted successfully');
    } else {
      // Error
      print('Failed to delete Comment. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    // Exception
    print('Error: $error');
  }
}
Future<bool> verifyPost(String postId, String token) async {
  final url = Constantes.urlPost+'/verifyPost/$postId' ; // Replace with your actual server URL
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token', // If you're using token-based authentication
      },
    );

    if (response.statusCode == 200) {
      // Handle successful verification
      return true;
    } else {
      // Handle failure
      print('Failed to verify post: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error verifying post: $e');
    return false;
  }
}
Future<bool> notVerifyPost(String postId, String token) async {
  final url = Constantes.urlPost+'/NotverifyPost/$postId' ; // Replace with your actual server URL
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token', // If you're using token-based authentication
      },
    );

    if (response.statusCode == 200) {
      // Handle successful operation
      return true;
    } else {
      // Handle failure
      print('Failed to not verify post: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error not verifying post: $e');
    return false;
  }
}

Future<bool> deletePostAndSendEmail(String postId, String token) async {
  final url = Constantes.urlPost+'/deleteAndSendEmail/$postId'; // Replace with your server URL
  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // If you're using token-based authentication
      },
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print('Post deleted successfully');
      return true;
    } else {
      // Handle server errors
      print('Failed to delete post: ${response.body}');
      return false;
    }
  } catch (e) {
    // Handle any errors
    print('Error deleting post: $e');
    return false;
  }
}



}
