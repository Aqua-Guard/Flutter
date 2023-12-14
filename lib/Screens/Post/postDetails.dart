import 'package:aquaguard/Models/post.dart';
import 'package:aquaguard/Screens/Post/allPostsScreen.dart';
import 'package:aquaguard/Services/PostWebService.dart';
import 'package:aquaguard/widgets/commentPost.dart';
import 'package:aquaguard/widgets/likesPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostDetails extends StatefulWidget {
  final Post post;
  String token;

  PostDetails({Key? key, required this.post, required this.token})
      : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  Future<bool?> showConfirmationDialog(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to delete this Post?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Responsive design adjustments
    var screenWidth = MediaQuery.of(context).size.width;
    var isDesktop = screenWidth > 600; // Example breakpoint for desktop

    return Theme(
        data: Theme.of(context).copyWith(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Post Details',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xff00689B),
              elevation: 0,
            ),
            body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background_splash_screen.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.blue, width: 2),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'http://localhost:9090/images/user/${widget.post.userImage}'),
                                  radius: isDesktop ? 40 : 25,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.post.userName,
                                        style: TextStyle(
                                            fontSize: isDesktop ? 20.0 : 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        '${widget.post.userRole}',
                                        style: TextStyle(
                                            fontSize: isDesktop ? 16.0 : 14.0,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            widget.post
                                .description, // Replace with your post description
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: isDesktop ? 18.0 : 14.0),
                          ),
                        ),
                        Image.network(
                          'http://localhost:9090/images/post/${widget.post.postImage}',
                          width: double.infinity,
                          height: isDesktop ? 400 : 200,
                          fit: BoxFit.cover,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child:
                                          LikesPost(likes: widget.post.likes),
                                    ),
                                  );
                                },
                                child: _buildIconText(Icons.favorite, "Like",
                                    "${widget.post.nbLike}", Colors.pink),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: CommentPost(
                                          comments: widget.post.comments),
                                    ),
                                  );
                                },
                                child: _buildIconText(Icons.comment, "Comment",
                                    "${widget.post.nbComments}", Colors.yellow),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('Share');
                                },
                                child: _buildIconText(Icons.share, "Share",
                                    "${widget.post.nbShare}", Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0), // Add space between buttons
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      bool? confirmed =
                                          await showConfirmationDialog(context);
                                      if (confirmed == true) {
                                        // User confirmed, you can perform additional actions if needed
                                        PostWebService().deletePost(
                                            widget.token, widget.post.idPost);
                                        Fluttertoast.showToast(
                                          msg: "Deleted successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AllPostsScreen(
                                                        token: widget.token)),
                                          );
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    label: const Text('Delete'),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(16.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))));
  }

  Widget _buildIconText(
      IconData icon, String label, String count, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(label),
        const SizedBox(width: 4),
        Text(count),
      ],
    );
  }
}
