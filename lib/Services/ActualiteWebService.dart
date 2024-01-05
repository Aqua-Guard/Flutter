import 'package:aquaguard/Models/actualite.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;


class ActualiteWebService{

Future<List<Actualite>> fetchActualite(String token) async {
  final response = await http.get(Uri.parse(Constantes.urlActualite),
      headers: {
        'Authorization': 'Bearer $token',
      },);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Actualite.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load actualite');
  }
}



 Future<void> addActualite({
required String token,
required String title,
required String description,
required String text,
required html.File fileimage,
required BuildContext context,
 })async {
 var uri = Uri.parse(Constantes.urlActualite);
    var request = http.MultipartRequest('POST', uri);
  request.headers['Authorization'] = 'Bearer $token';
      request.fields['title'] = title;
      request.fields['desc'] = description;
      request.fields['text'] = text;
 // Read the image file as bytes
    Uint8List imageBytes = await _readFileBytes(fileimage);

    // Add image file
    var multipartFile = http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: fileimage.name,
      contentType: MediaType('image','jpeg'),
    );
       request.files.add(multipartFile);



         try {
      var response = await request.send();
      if (response.statusCode == 200) {

        SnackBar snackBar = const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check, color: Colors.white),
              SizedBox(width: 8),
              Text('actualite added successfully!',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.green,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        print('actualite Added Successfully!');
      } else {
        SnackBar snackBar = SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              Text('Failed to add actualite. Status code: ${response.statusCode}',
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.red,
        );

        print('Failed to add actualite. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (error) {
      SnackBar snackBar = SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Text('Error adding actualite: $error',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
      );

      print('Error adding actualite: $error');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  Future<Uint8List> _readFileBytes(html.File file) async {
    final html.FileReader reader = html.FileReader();

    // Read file as data URL (base64 encoded)
    reader.readAsArrayBuffer(file);

    // Wait for the reading to complete
    await reader.onLoad.first;

    // Get the result as Uint8List
    return Uint8List.fromList(reader.result as List<int>);
  }




  //////search functin with openai 
  ///Future<List<Actualite>> searchActualites(String token, String about, BuildContext context) async {
    /// searshfunction with open ai 
    
    Future<List<Actualite>> SmartsearchActualites(String token, String about, BuildContext context) async {
    var uri = Uri.parse(Constantes.urlActualite+"/search");
    print('About parameter=============---------------==========: $about');
  var requestBody = json.encode({'about': about});

  var request = http.Request('POST', uri);
  request.headers['Content-Type'] = 'application/json';
  request.headers['Authorization'] = 'Bearer $token';
  request.body = requestBody;
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(await response.stream.bytesToString());
        return data.map((json) => Actualite.fromJson(json)).toList();
      } else {
        // Handle the error
        print('Failed to search actualites. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      // Handle the error
      print('Error searching actualites: $error');
      return [];
    }
  }

  }

 






   
