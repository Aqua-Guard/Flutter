

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TotalPostsCard extends StatelessWidget {
  final int totalPosts; // Total number of posts

  const TotalPostsCard({Key? key, required this.totalPosts}) : super(key: key);

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
            Text(
              'Total Posts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '$totalPosts', // Display the total number of posts
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  
  }
}
