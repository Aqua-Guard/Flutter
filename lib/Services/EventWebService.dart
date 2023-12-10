import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


const authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTVmZjc5MDdkYjE5NTYxMzcyNmNkYjQiLCJ1c2VybmFtZSI6Im1vaGFtZWQiLCJpYXQiOjE3MDIxNjUwNzAsImV4cCI6MTcwMjE3MjI3MH0.upFMwKE6JgtAG2qcj1_ax1BXA4Q7UcvDjQXTWNsZhFU";
class EventWebService{

Future<List<Event>> fetchEvents() async {
  final response = await http.get(Uri.parse(Constantes.urlParticipation),
  headers:  {
        'Authorization': 'Bearer $authToken',
        
      },);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Event.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load events');
  }
}


Future<void> deleteParticipation(String eventId, String userId) async {
  final url = Uri.parse('$Constantes.urlParticipation/$eventId/$userId');

  try {
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
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



Future<List<Map<String, dynamic>>> fetchEventsNbParticipants() async {
  final response = await http.get(
    Uri.parse('$Constantes.urlEvent/stats'),
    headers: {
      'Authorization': 'Bearer $authToken',
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
}

