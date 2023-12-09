import 'package:aquaguard/Components/MyAppBar.dart';
import 'package:aquaguard/Components/MyDrawer.dart';
import 'package:aquaguard/Models/comment.dart';
import 'package:aquaguard/Models/like.dart';
import 'package:aquaguard/Models/post.dart';
import 'package:aquaguard/widgets/LatestPostCard.dart';
import 'package:aquaguard/widgets/barChartCard.dart';
import 'package:aquaguard/widgets/totalPostsCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {

  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late final List<Comment> comments;
  late final List<Like> likes;
  late final List<Post> myLatestPost;
  int _selectedIndex = 3;

   @override
  void initState() {
    super.initState();

    // Initialize comments
    comments = [
      Comment(idUser: '1', idPost: 'post1', idComment: 'comment1', commentAvatar: 'avatar1.png', commentUsername: 'User 1', comment: 'Great post!'),
      Comment(idUser: '2', idPost: 'post1', idComment: 'comment2', commentAvatar: 'avatar2.png', commentUsername: 'User 2', comment: 'Interesting read.'),
    ];

    // Initialize likes
    likes = [
      Like(idLike: '1', likeAvatar: 'post1', likeUsername: 'youssef'), 
      Like(idLike: '2', likeAvatar: 'post1', likeUsername: 'youssef'),
    ];

    // Initialize myLatestPost
    myLatestPost = [ Post(
      idPost: '6550ea27aac01c964b6b9e95',
      userName: 'youssef',
      userRole: 'consommateur',
      userImage: 'assets/images/youssef.jpg',
      description: 'Dive into the serene beauty of aquatic life with AquaGard!',
      postImage: '1699801639506.png',
      nbLike: 2,
      nbComments: 2,
      nbShare: 5,
      comments: comments,
      likes: likes,
    ),Post(
      idPost: '6550ea27aac01c964b6b9e95',
      userName: 'Youssef Farhat',
      userRole: 'consommateur',
      userImage: '/images/user1.jpg',
      description: 'Dive into the serene beauty of aquatic life with AquaGard!',
      postImage: '1699801639506.png',
      nbLike: 2,
      nbComments: 2,
      nbShare: 5,
      comments: comments,
      likes: likes,
    ),Post(
      idPost: '6550ea27aac01c964b6b9e95',
      userName: 'Youssef Farhat',
      userRole: 'consommateur',
      userImage: '/images/user2.jpg',
      description: 'Dive into the serene beauty of aquatic life with AquaGard!',
      postImage: '1699801639506.png',
      nbLike: 2,
      nbComments: 2,
      nbShare: 5,
      comments: comments,
      likes: likes,
    )];
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
          appBar:  MyAppBar(),
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
                  const Padding(
                    
                    padding: EdgeInsets.all(8.0),
                    child: TotalPostsCard(
                        totalPosts:
                            20), // Replace 100 with your total posts count
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BarChartCard(),
                    ),
                  ),
                  Padding(
                   
                    padding: const EdgeInsets.all(8.0),
                    child: LatestPostCard(
                      latestPosts: myLatestPost, // Replace with your latest Post object
                    ),
                  ),
                ],
              ),
            ],
          ),
          drawer:  MyDrawer(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
       
        ));
  }
}
