import 'package:aquaguard/Models/Event.dart';
import 'package:aquaguard/Utils/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


//const authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTVmZjc5MDdkYjE5NTYxMzcyNmNkYjQiLCJ1c2VybmFtZSI6Im1vaGFtZWQiLCJpYXQiOjE3MDIyMDQzMDIsImV4cCI6MTcwMjIxMTUwMn0.qBlg9t3qnvkAC78LZbvvT2rVpkgF-rpO0ybxIjYGr1E";
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
  final url = Uri.parse('$Constantes.urlParticipation/$eventId/$userId');

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
    Uri.parse(Constantes.urlEvent+'/stats'),
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
}

