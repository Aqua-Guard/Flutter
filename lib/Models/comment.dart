
class Comment {
  String idUser;
  String idPost;
  String idComment;
  String commentAvatar;
  String commentUsername;
  String comment;

  Comment({
   required this.idUser,
   required this.idPost,
   required this.idComment,
   required this.commentAvatar,
   required this.commentUsername,
   required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      idUser: json['idUser'],
      idPost: json['idPost'],
      idComment: json['idComment'],
      commentAvatar: json['commentAvatar'],
      commentUsername: json['commentUsername'],
      comment: json['comment'],
    );
  }
}