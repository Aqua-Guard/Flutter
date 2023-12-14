import 'dart:html';
import 'package:aquaguard/Models/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CommentPost extends StatefulWidget {
  final List<Comment> comments;

  const CommentPost({Key? key,required this.comments}) : super(key: key);

  @override
  State<CommentPost> createState() => _CommentPostState();
}

class _CommentPostState extends State<CommentPost> {
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
            child: Icon(Icons.comment, size: 50, color: Color.fromARGB(255, 255, 139, 0)),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Post Commented by ', style: TextStyle(fontSize: 20)),
                Text('${widget.comments.length}',
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 255, 139, 0),
                        fontWeight: FontWeight.bold)),
                Text(' Person:', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          if (widget.comments.isEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('Note.png',
                      width: 250), // Replace with your image
                  Text('No Comment',
                      style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 139, 0))),
                ],
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: widget.comments.length,
                itemBuilder: (context, index) {
                  // Retrieve the 'like' object for the current index
                  var comment = widget.comments[index];

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
                                  (comment.commentAvatar ?? ""),
                            ),
                            onBackgroundImageError: (_, __) =>
                                Icon(Icons.person, size: 60),
                            backgroundColor: Colors.transparent,
                          ),
                          // User name
                          title: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              comment.commentUsername ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Liked Text and Icon
                          subtitle: Row(
                            children: [
                              Text(comment.comment ?? "",
                                  style: TextStyle(color: Colors.black)),
                              
                            ],
                           
                          ),
                          trailing: Icon(Icons.comment, color: Color.fromARGB(255, 255, 139, 0)),
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
