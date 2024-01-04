import 'package:aquaguard/Models/comment.dart';
import 'package:aquaguard/Models/like.dart';

class Post {
  String idPost;
  String userName;
  String? userRole; // Making userRole nullable
  String? userImage; // Making userImage nullable
  String description;
  String postImage;
  int nbLike;
  int nbComments;
  int nbShare;
  List<Comment> comments;
  List<Like> likes;
  String postedAt;
  bool? verified;

  Post({
    required this.idPost,
    required this.userName,
    this.userRole, // Nullable
    this.userImage, // Nullable
    required this.description,
    required this.postImage,
    required this.nbLike,
    required this.nbComments,
    required this.nbShare,
    required this.comments,
    required this.likes,
    required this.postedAt,
    required this.verified,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    var commentList = json['comments'] as List;
    var likeList = json['likes'] as List;
    List<Comment> comments = commentList.map((i) => Comment.fromJson(i)).toList();
    List<Like> likes = likeList.map((i) => Like.fromJson(i)).toList();    
    return Post(
      idPost: json['idPost'],
      userName: json['userName'],
      userRole: json['userRole'], // Nullable
      userImage: json['userImage'], // Nullable
      description: json['description'],
      postImage: json['postImage'],
      nbLike: json['nbLike'],
      nbComments: json['nbComments'],
      nbShare: json['nbShare'],
      postedAt: json['postedAt'],
      verified: json['verified'],
      comments: comments,
      likes: likes,
    );
  }
}
