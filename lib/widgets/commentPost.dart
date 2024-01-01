import 'dart:html';
import 'package:aquaguard/Models/comment.dart';
import 'package:aquaguard/Services/PostWebService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentPost extends StatefulWidget {
  final List<Comment> comments;
  String token;

  CommentPost({Key? key, required this.comments, required this.token})
      : super(key: key);

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
            child: Icon(Icons.comment,
                size: 50, color: Color.fromARGB(255, 255, 139, 0)),
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
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 139, 0))),
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
                        child: FutureBuilder<bool?>(
                          future: PostWebService().detectDiscriminationInText(
                              comment.comment, widget.token),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Show a placeholder or loading indicator while waiting for the response
                              return ListTile(
                                leading: CircleAvatar(radius: 30),
                                title: Text(comment.commentUsername ?? ""),
                                subtitle: Text(comment.comment ?? ""),                       
                              );
                            }

                            bool isDiscriminated = snapshot.data ?? false;
                            return ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      "http://127.0.0.1:9090/images/user/" +
                                          (comment.commentAvatar ?? ""))),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  comment.commentUsername ?? "",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(comment.comment ?? "",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Ensure Row size is based on children size
                                children: [
                                  if (isDiscriminated)
                                      Icon(Icons.warning, color:  Color.fromARGB(255, 255, 139, 0)),
                                  
                                 if(true)
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Delete Comment"),
                                            content: Text(
                                                "Are you sure you want to delete this comment?"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                              ),
                                              TextButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                PostWebService().deleteComment(widget.token, comment.idComment);
                                                  Navigator.of(context)
                                                      .pop(); 
                                                        SnackBar snackBar = const SnackBar(
                                      content:  Row(
                                        children: [
                                           Icon(Icons.error,color: Colors.white), 
                                           SizedBox(width:8), 
                                          Text("Comment deleted successfully",style:  TextStyle(color: Colors.white)),
                                        ],
                                      ),
                                      backgroundColor: Colors.green, // Use red color for error messages
                                    );
                 
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);// Close the dialog
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
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
