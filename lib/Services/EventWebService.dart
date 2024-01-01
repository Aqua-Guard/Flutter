import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Models/partenaire.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class EventWebService {
  Future<List<Event>> fetchEvents(String token) async {
    final response = await http.get(
      Uri.parse(Constantes.urlEvent),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<void> deleteParticipation(
      String token, String eventId, String userId, BuildContext context) async {
    final url = Uri.parse('${Constantes.urlParticipation}/$eventId/$userId');

    try {
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Success
        print('Participation deleted successfully');
      } else {
        // Error
        print(
            'Failed to delete participation. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      // Exception
      SnackBar snackBar = SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Text('Error adding event: $error',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red, // Use red color for error messages
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print('Error: $error');
    }
  }

  Future<List<Map<String, dynamic>>> fetchEventsNbParticipants(
      String token) async {
    final response = await http.get(
      Uri.parse('${Constantes.urlEvent}/stats'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      List<Map<String, dynamic>> eventsList = data.map((json) {
        return {
          'idEvent': json['_id'],
          'eventName': json['eventName'],
          'nbParticipants': json['nbParticipants'],
        };
      }).toList();

      return eventsList;
    } else {
      throw Exception('Failed to load events stats');
    }
  }

  Future<List<Partenaire>> fetchPartenaires() async {
    final response = await http.get(
      Uri.parse('${Constantes.baseUrl}/getPartenaires'),

      /* headers:  {
        'Authorization': 'Bearer $token',
        
      },*/
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Partenaire.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load partenaires');
    }
  }

  Future<void> addEventByAdmin({
    required String token,
    required String userId,
    required String name,
    required String dateDebut,
    required String dateFin,
    required String description,
    required String lieu,
    required html.File fileimage,
    required BuildContext context,
  }) async {
    var uri = Uri.parse(Constantes.urlEvent);
    var request = http.MultipartRequest('POST', uri);

    // Add token to headers
    request.headers['Authorization'] = 'Bearer $token';

    // Add form fields
    request.fields['userId'] = userId;
    request.fields['name'] = name;
    request.fields['DateDebut'] = dateDebut;
    request.fields['DateFin'] = dateFin;
    request.fields['Description'] = description;
    request.fields['lieu'] = lieu;

    // Read the image file as bytes
    Uint8List imageBytes = await _readFileBytes(fileimage);

    // Add image file
    var multipartFile = http.MultipartFile.fromBytes(
      'image',
      imageBytes,
      filename: fileimage.name,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        SnackBar snackBar = const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check, color: Colors.white),
              SizedBox(width: 8),
              Text('Event added successfully!',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.green,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        print('Event Added Successfully!');
      } else {
        SnackBar snackBar = SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              Text('Failed to add event. Status code: ${response.statusCode}',
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.red,
        );

        print('Failed to add event. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (error) {
      SnackBar snackBar = SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Text('Error adding event: $error',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
      );

      print('Error adding event: $error');
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



Future<String?> generateWithChatGPT(String promptString, String token) async {
  try {
    // Assuming the prompt is the event name
    String prompt = promptString;

    // Make a GET request to the endpoint
    final response = await http.get(
      Uri.parse(Constantes.urlEvent+'/generateDescriptionWithChat/$prompt'),
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
/*
Future<void> updateEventStatus(String eventId, String authToken) async {
  final url = Uri.parse(Constantes.urlEvent+'/updateStatus/$eventId');

  try {
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      print('Event status updated successfully');
      // Handle success, if needed
    } else {
      print('Failed to update event status: ${response.statusCode}');
      // Handle error, if needed
    }
  } catch (error) {
    print('Error updating event status: $error');
    // Handle error, if needed
  }
}*/

}

