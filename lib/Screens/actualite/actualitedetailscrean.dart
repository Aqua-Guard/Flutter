import 'package:flutter/material.dart';
import 'package:aquaguard/Models/actualite.dart';

class newsdetail extends StatefulWidget {
  String token;
  Actualite news;

  newsdetail({Key? key, required this.token, required this.news}) : super(key: key);

  @override
  State<newsdetail> createState() => _newsdetail();
}

class _newsdetail extends State<newsdetail> {
 // Inside the _newsdetail state class

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.news.title),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              widget.news.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.news.description,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.news.text,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          // Add any other text or content here

          // Display the image if available
          // if (widget.news.imageUrl != null)
          //   Image.network(
          //     widget.news.imageUrl!,
          //     height: 200,
          //     width: double.infinity,
          //     fit: BoxFit.cover,
          //   ),
        ],
      ),
    ),
  );
}
}