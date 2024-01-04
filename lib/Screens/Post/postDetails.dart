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
  final Function onPostUpdated;

  PostDetails({Key? key, required this.post, required this.token, required this.onPostUpdated}) : super(key: key);


  @override
  State<PostDetails> createState() => _PostDetailsState();
}

enum VerificationStatus { notVerified, verified, failed }

class _PostDetailsState extends State<PostDetails> {
  VerificationStatus verificationStatus = VerificationStatus.notVerified;

  @override
  void initState() {
    super.initState();

    verificationStatus = widget.post.verified == true
        ? VerificationStatus.verified
        : widget.post.verified == false
            ? VerificationStatus.failed
            : VerificationStatus.notVerified;
  }

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
                              // i want to add the tile of the post posted at on the left side of the container(${widget.post.postedAt})
                              // and i want to add bottom have text that tel inside the bottom (tcheck the content of the post )to see if it contains discrimination just static btn with pretty ched icon
                              Text(
                                '${widget.post.postedAt}',
                                style: TextStyle(
                                    fontSize: isDesktop ? 16.0 : 14.0),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: TextButton(
                                  onPressed: () async {
                                    // Initial status set based on widget.post.verified

                                    // Call the function to check for discriminatory content
                                    bool? isDiscriminatory =
                                        await PostWebService()
                                            .detectDiscriminationInPost(
                                                widget.post.idPost,
                                                widget.token);

                                    if (isDiscriminatory != null) {
                                      // Show dialog and ask for user confirmation
                                      bool verify = await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Post Verification'),
                                                content: Text(
                                                    'Based on Chat GPT, the description of this post ${isDiscriminatory ? "does" : "does not"} include discrimination. Do you want to verify this post?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Verify'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop(
                                                          true); // Close dialog and proceed with verification
                                                      PostWebService()
                                                          .verifyPost(
                                                              widget
                                                                  .post.idPost,
                                                              widget.token);
                                                              widget.onPostUpdated();
                                                      // Show SnackBar
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'Post verified successfully'),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Dont Verify',
                                                        style: TextStyle(
                                                            color: Colors.red)),
                                                    onPressed: () {
                                                      Navigator.of(context).pop(
                                                          false); // Close dialog and proceed with not verifying
                                                      PostWebService()
                                                          .notVerifyPost(
                                                              widget
                                                                  .post.idPost,
                                                              widget.token);
                                                              widget.onPostUpdated();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'Post verification declined'),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ) ??
                                          false; // Handle null (dialog dismissed)

                                      // Update the UI based on the user's decision
                                      if (verify) {
                                        setState(() {
                                          verificationStatus =
                                              VerificationStatus.verified;
                                          widget.post.verified =
                                              true; // Update the post's verified status
                                        });
                                      } else {
                                        setState(() {
                                          verificationStatus =
                                              VerificationStatus.failed;
                                          widget.post.verified =
                                              false; // Update the post's verified status
                                        });
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // Keep the row size to the size of its children
                                    children: [
                                      Icon(
                                        verificationStatus ==
                                                VerificationStatus.verified
                                            ? Icons.check_circle
                                            : verificationStatus ==
                                                    VerificationStatus.failed
                                                ? Icons.close_rounded
                                                : Icons.warning,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        verificationStatus ==
                                                VerificationStatus.verified
                                            ? "Verified"
                                            : verificationStatus ==
                                                    VerificationStatus.failed
                                                ? "Not Verified"
                                                : "Not Verified Yet",
                                      ),
                                    ],
                                  ),
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: verificationStatus ==
                                            VerificationStatus.verified
                                        ? Colors.green
                                        : verificationStatus ==
                                                VerificationStatus.failed
                                            ? Colors.red
                                            : Colors.orange,
                                    onSurface: Colors.grey,
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
                                          onPostUpdated : widget.onPostUpdated,
                                          comments: widget.post.comments,
                                          token: widget.token),
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
