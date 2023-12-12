import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Models/partenaire.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EventWebService{

Future<List<Event>> fetchEvents(String token) async {
  final response = await http.get(Uri.parse(Constantes.urlEvent),
 
  headers:  {
        'Authorization': 'Bearer $token',
        
      },);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Event.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load events');
  }
}


Future<void> deleteParticipation(String token,String eventId, String userId) async {
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
      print('Failed to delete participation. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    // Exception
    print('Error: $error');
  }
}



Future<List<Map<String, dynamic>>> fetchEventsNbParticipants(String token) async {

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
  final response = await http.get(Uri.parse('${Constantes.baseUrl}/getPartenaires'),
 
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
  required XFile image,
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
  request.fields['image'] =  image.path.split('.').last;


  try {
    var response = await request.send();
    if (response.statusCode == 201) {
      print('Event Added Successfully!');
    } else {
      print('Failed to add event. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error adding event: $error');
  }
}


}








