import 'package:aquaguard/Components/MyAppBar.dart';
import 'package:aquaguard/Components/MyDrawer.dart';
import 'package:aquaguard/Models/comment.dart';
import 'package:aquaguard/Models/like.dart';
import 'package:aquaguard/Models/post.dart';
import 'package:aquaguard/Services/PostWebService.dart';
import 'package:aquaguard/widgets/LatestPostCard.dart';
import 'package:aquaguard/widgets/barChartCard.dart';
import 'package:aquaguard/widgets/totalPostsCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  String token;
  PostScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
late List<Post> postData = [];
  int _selectedIndex = 3;
  
  @override
  void initState() {
    super.initState();

    PostWebService()
        .getAllPosts(widget.token)
        .then((posts) => {
              setState(() {
                postData = posts;          
              })
            })
        .catchError((error) {
      print("Error Fetch posts: " + error);
    });
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
                   Padding(  
                    padding: EdgeInsets.all(8.0),
                    child: TotalPostsCard(
                        totalPosts: postData.length ), // Replace 100 with your total posts count
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BarChartCard(token : widget.token),
                    ),
                  ),
                  Padding(
                   
                    padding: const EdgeInsets.all(8.0),
                    child: LatestPostCard(token : widget.token,postData: postData),
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
