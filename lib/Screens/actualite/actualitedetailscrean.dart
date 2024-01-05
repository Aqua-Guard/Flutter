import 'package:aquaguard/Utils/constantes.dart';
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
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var isDesktop = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_splash_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  '${Constantes.urlImgactualite}/${widget.news.image}',
                  width: double.infinity,
                  height: isDesktop ? 400 : 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Text(
                  "Description : ${widget.news.description}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Text : ${widget.news.text}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
