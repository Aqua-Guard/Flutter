import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TotalEventsCard extends StatelessWidget {
  final int totalEvents; // Total number of events

  const TotalEventsCard({Key? key, required this.totalEvents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      // add background color white 
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Total Events',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '$totalEvents', // Display the total number of posts
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  
  }
}
