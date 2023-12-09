import 'package:aquaguard/Models/Event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var uri = 'http://localhost:9090/events/admin';
const authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTVmZjc5MDdkYjE5NTYxMzcyNmNkYjQiLCJ1c2VybmFtZSI6Im1vaGFtZWQiLCJpYXQiOjE3MDIxNDIxMjksImV4cCI6MTcwMjE0OTMyOX0.kJv46--s8sLcShhbQsbNXmJpALxDUyCRPQL-KMI_Ons";

Future<List<Event>> fetchEvents() async {
  final response = await http.get(Uri.parse(uri),
  headers:  {
        'Authorization': 'Bearer $authToken',
        // Add other headers if needed
      },);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Event.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load events');
  }
}