import 'package:aquaguard/Models/comment.dart';
import 'package:aquaguard/Models/like.dart';

class Post {
  final String idPost;
  final String userName;
  final String userRole;
  final String userImage;
  final String description;
  final String postImage;
  final int nbLike;
  final int nbComments;
  final int nbShare;
  final List<Comment> comments;
  final List<Like> likes;

  Post({
    required this.idPost,
    required this.userName,
    required this.userRole,
    required this.userImage,
    required this.description,
    required this.postImage,
    required this.nbLike,
    required this.nbComments,
    required this.nbShare,
    required this.comments,
    required this.likes,
  });
  
}
