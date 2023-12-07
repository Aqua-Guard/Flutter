import 'package:aquaguard/Models/comment.dart';
import 'package:aquaguard/Models/like.dart';
import 'package:aquaguard/Models/post.dart';
import 'package:aquaguard/Screens/Post/AddPostForm.dart';

import 'package:aquaguard/widgets/allPostList.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllPostsScreen extends StatefulWidget {
  const AllPostsScreen({Key? key}) : super(key: key);

  @override
  State<AllPostsScreen> createState() => _AllPostsScreenState();
}

class _AllPostsScreenState extends State<AllPostsScreen> {
  late final List<Comment> comments;
  late final List<Like> likes;
  late final List<Post> myLatestPost;

  @override
  void initState() {
    super.initState();

    // Initialize comments
    comments = [
      Comment(
          idUser: '1',
          idPost: 'post1',
          idComment: 'comment1',
          commentAvatar: 'avatar1.png',
          commentUsername: 'User 1',
          comment: 'Great post!'),
      Comment(
          idUser: '2',
          idPost: 'post1',
          idComment: 'comment2',
          commentAvatar: 'avatar2.png',
          commentUsername: 'User 2',
          comment: 'Interesting read.'),
    ];

    // Initialize likes
    likes = [
      Like(idLike: '1', likeAvatar: 'post1', likeUsername: 'youssef'),
      Like(idLike: '2', likeAvatar: 'post1', likeUsername: 'youssef'),
    ];

    // Initialize myLatestPost
    myLatestPost = [
      Post(
        idPost: '6550ea27aac01c964b6b9e95',
        userName: 'Adem Seddik',
        userRole: 'consommateur',
        userImage: 'assets/images/youssef.jpg',
        description:
            "Dive into the serene beauty of aquatic life with AquaGard! 🐠💧 Whether you're a seasoned aquarist or just starting your water gardening journey, our latest post offers a treasure trove of insights!",
        postImage: '/images/post1.jpg',
        nbLike: 2,
        nbComments: 2,
        nbShare: 5,
        comments: comments,
        likes: likes,
      ),
      Post(
        idPost: '6550ea27aac01c964b6b9e95',
        userName: 'Youssef Farhat',
        userRole: 'Admin',
        userImage: '/images/user1.jpg',
        description:
            'Dive into the serene beauty of aquatic life with AquaGard!',
        postImage: '/images/post2.jpg',
        nbLike: 2,
        nbComments: 2,
        nbShare: 5,
        comments: comments,
        likes: likes,
      ),
      Post(
        idPost: '6550ea27aac01c964b6b9e95',
        userName: 'Salima ben Salah',
        userRole: 'Partner',
        userImage: '/images/user2.jpg',
        description:
            'Dive into the serene beauty of aquatic life with AquaGard!',
        postImage: '/images/post3.jpg',
        nbLike: 2,
        nbComments: 2,
        nbShare: 5,
        comments: comments,
        likes: likes,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          // This will change the drawer icon color
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('All Posts',style: TextStyle( color: Colors.white )),

            backgroundColor: Color(0xff00689B),

            elevation: 0,
          ),
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background_splash_screen.png'),
                    fit: BoxFit
                        .cover, // This will fill the background of the container, you can change it as needed.
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    // Expanded should be a direct child of Column
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AllPostsList(
                        latestPosts: myLatestPost,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
            floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddPostForm()),
              );
            },
            backgroundColor: const Color(0xff00689B),
            shape: const CircleBorder(), // Set FAB background color
            child: const Icon(
              Icons.add,
              color: Colors.white, // Set the color of the icon to white
            ), // Make the FAB circular
          ), 
        ));
  }
}
