import 'package:aquaguard/Models/comment.dart';
import 'package:aquaguard/Models/like.dart';
import 'package:aquaguard/Models/post.dart';

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
            // title: const Text('Post',style: TextStyle( color: Colors.white // Set text color to white
            // Make text bold)

            backgroundColor: Color(0xff00689B),

            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Search something...",
                        icon: Icon(CupertinoIcons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  color: Colors.white,
                  onPressed: () {
                    // Handle notification icon action
                  },
                ),
                const CircleAvatar(
                  // Replace with your image
                  backgroundImage: AssetImage('assets/images/youssef.jpg'),
                )
              ],
            ),
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
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Stack(children: [
                    Image.asset(
                      "assets/nav_header.png",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    // Align(
                    //   alignment: Alignment.center,
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.transparent,
                    //       radius: 40,
                    //       child: Container(
                    //           width: MediaQuery.of(context).size.width * .3,
                    //           height: MediaQuery.of(context).size.height * .3,
                    //           child: Image.asset("assets/profile_pic.png")
                    //       ),
                    //     ),
                    // ),
                  ]),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_rounded),
                  title: const Text('Users'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.event),
                  title: const Text('Events'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.post_add),
                  title: const Text('Posts'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.store),
                  title: const Text('Store'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text('Reclamation'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
