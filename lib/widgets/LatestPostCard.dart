import 'package:aquaguard/Models/post.dart';
import 'package:aquaguard/Screens/Post/allPostsScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class LatestPostCard extends StatefulWidget {
  String token ;
 List<Post> postData = [];

  LatestPostCard({Key? key,required this.token,required this.postData}) : super(key: key);

 @override
  State<LatestPostCard> createState() => _LatestPostCardState();
}
class _LatestPostCardState extends State<LatestPostCard> {


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Last 3 Posts Posted',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextButton(
                  child: Text('See All'),
                  onPressed: () {

                     Navigator.of(context).push(
                       MaterialPageRoute(
                           builder: (context) => AllPostsScreen(token : widget.token)),
                    );
                  },
                ),
              ],
            ),
             SizedBox(height: 10),
            ...widget.postData.take(3)
                .map((post) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage('http://localhost:9090/images/user/${post.userImage}'),
                            radius: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.userName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                 '${post.postedAt}' , // Replace with post's actual date
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.thumb_up, color: Colors.blue),
                          Text(' ${post.nbLike} Likes'),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
