import 'package:aquaguard/Models/post.dart';
import 'package:flutter/material.dart';

class AllPostsList extends StatelessWidget {
  final List<Post> latestPosts;

  const AllPostsList({Key? key, required this.latestPosts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: latestPosts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(latestPosts[index]);
      },
    );
  }

  Widget _buildPostCard(Post post) {
    return Card(
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
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                        post.postImage), // Using the userImage from Post
                    radius: 25, // Adjust the size as needed
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.userName, // Using the userName from Post
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                         " post.userRole", // Using the userRole from Post
                          style: const TextStyle(
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
              post.description, // Using the description from Post
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Image.asset(
            post.postImage, // Using the postImage from Post
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
                  _buildIconText(Icons.favorite, "Like", post.nbLike.toString(),
                      Colors.pink),
                  _buildIconText(Icons.comment, "Comment",
                      post.nbComments.toString(), Colors.yellow),
                  _buildIconText(Icons.share, "Share", post.nbShare.toString(),
                      Colors.blue),
                ],
              ),
            ),
          ),
        ],
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
