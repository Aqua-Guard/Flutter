import 'package:aquaguard/Models/post.dart';
import 'package:aquaguard/Screens/Post/allPostsScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class LatestPostCard extends StatelessWidget {
  final List<Post> latestPosts;

  LatestPostCard({Key? key, required this.latestPosts}) : super(key: key);

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
                          builder: (context) => AllPostsScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...latestPosts
                .map((post) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(post.userImage),
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
                                  intl.DateFormat.yMMMd().format(DateTime
                                      .now()), // Replace with post's actual date
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
