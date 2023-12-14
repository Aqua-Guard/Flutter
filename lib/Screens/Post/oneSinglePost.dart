import 'package:aquaguard/Screens/Post/postScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';





class OneSinglePost extends StatelessWidget {
  OneSinglePost({Key? key, required this.postDescription}) : super(key: key);

  String postDescription;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height : 550,
      child: Card(
       
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    // Add padding around the image
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Make it round
                      border: Border.all(
                          color: Colors.blue, width: 2), // Add a blue border
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                          "/images/youssef.jpg"), // Using the userImage from Post
                      radius: 25, // Adjust the size as needed
                    ),
                  ),
                   const Expanded(
                    child: Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Youssef Farhat", // Using the userName from Post
                            style:  TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                           SizedBox(height: 8.0),
                          Text(
                            "Admin", // Using the userRole from Post
                            style:  TextStyle(
                                fontSize: 14.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete,
                        color: Colors
                            .red), // Replace with info icon and make it blue
                    onPressed: () {
                      // Implement info functionality
                    },
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
                postDescription, // Using the description from Post
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Image.asset(
              "/images/post1.jpg", // Using the postImage from Post
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildIconText(Icons.favorite, "Like", "0", Colors.pink),
                    _buildIconText(
                        Icons.comment, "Comment", "0", Colors.yellow),
                    _buildIconText(Icons.share, "Share", "0", Colors.blue),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(200, 50)),
                  onPressed: () {
                    // Add your logic to delete the pile here
                    // Display a toast message
                    Fluttertoast.showToast(
                        msg: "Post created with success",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    // Delay Navigation to PostScreen
                    // Future.delayed(Duration(seconds: 3), () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => PostScreen()),
                    //   );
                    // });
                  },
                  child: const Text(
                    "Validate Creation Post",
                    style:  TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff00689B)),
                  ),
                ))
          ],
        ),
      ),
    );
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
