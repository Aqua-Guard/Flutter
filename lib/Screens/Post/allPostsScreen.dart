import 'dart:html';

import 'package:aquaguard/Models/comment.dart';
import 'package:aquaguard/Models/like.dart';
import 'package:aquaguard/Models/post.dart';
import 'package:aquaguard/Screens/Post/addPostForm.dart';
import 'package:aquaguard/Screens/Post/postDetails.dart';
import 'package:aquaguard/Services/PostWebService.dart';

import 'package:aquaguard/widgets/allPostList.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllPostsScreen extends StatefulWidget {
  String token;

  AllPostsScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<AllPostsScreen> createState() => _AllPostsScreenState();
}

class _AllPostsScreenState extends State<AllPostsScreen> {
  late List<Post> postData = [];
  late List<Post> postDataOriginal = [];
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    PostWebService()
        .getAllPosts(widget.token)
        .then((posts) {
      setState(() {
        postData = posts;
        postDataOriginal = List.from(postData);
      });
    })
    .catchError((error) {
      print("Error Fetch posts: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (postData.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Post List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff00689B),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_splash_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 60, // Adjust the height as needed
                  child: Card(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search by Description',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              postData = postDataOriginal;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          postData = postDataOriginal
                              .where((post) => post.description
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                ),
                if (postData.isEmpty)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/Post_not_found.png",
                          height: 400,
                          width: 400,
                        ),
                        const SizedBox(height: 8.0),
                        const Text("No Post Found"),
                      ],
                    ),
                  ),
                if (postData.isNotEmpty)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Card(
                        elevation: 4,
                        child: DataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                'Post UserName',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff00689B),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'User Role',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff00689B),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff00689B),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Number of Likes',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff00689B),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Number of Comments',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff00689B),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Actions',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff00689B),
                                ),
                              ),
                            ),
                          ],
                          rows: postData.map((post) {
                            return DataRow(
                              cells: [
                                DataCell(Text(post.userName)),
                                DataCell(Text('${post.userRole}')),
                                DataCell(Text(post.description)),
                                DataCell(Text('${post.nbLike}')),
                                DataCell(Text('${post.nbComments}')),
                                DataCell(
                                  IconButton(
                                    icon: const Icon(
                                      Icons.info,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PostDetails(
                                            post: post,
                                            token: widget.token,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPostForm(token: widget.token),
            ),
          );
        },
        backgroundColor: const Color(0xff00689B),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
