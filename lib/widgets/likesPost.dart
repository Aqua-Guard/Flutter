import 'package:aquaguard/Models/like.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikesPost extends StatefulWidget {
  final List<Like> likes;

  const LikesPost({Key? key, required this.likes}) : super(key: key);

  @override
  State<LikesPost> createState() => _LikesPostState();
}

class _LikesPostState extends State<LikesPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // Add your background decoration here
          ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(Icons.favorite, size: 50, color: Colors.pink),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Post liked by ', style: TextStyle(fontSize: 20)),
                Text('${widget.likes.length}',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold)),
                Text(' Person:', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          if (widget.likes.isEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('Heartbroken.png',
                      width: 250), // Replace with your image
                  Text('No Likes',
                      style: TextStyle(fontSize: 20, color: Colors.pink)),
                ],
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: widget.likes.length,
                itemBuilder: (context, index) {
                  // Retrieve the 'like' object for the current index
                  var like = widget.likes[index];

                  return Column(
                    children: [
                      Divider(color: Colors.grey.withOpacity(0.5)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          // User avatar
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              "http://127.0.0.1:9090/images/user/" +
                                  (like.likeAvatar ?? ""),
                            ),
                            onBackgroundImageError: (_, __) =>
                                Icon(Icons.person, size: 60),
                            backgroundColor: Colors.transparent,
                          ),
                          // User name
                          title: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              like.likeUsername ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Liked Text and Icon
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Liked",
                                  style: TextStyle(color: Colors.pink)),
                              Icon(Icons.favorite, color: Colors.pink),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
