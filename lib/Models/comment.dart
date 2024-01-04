
class Comment {
  String idUser;
  String idPost;
  String idComment;
  String commentAvatar;
  String commentUsername;
  String comment;
  String commentedAt;

  Comment({
   required this.idUser,
   required this.idPost,
   required this.idComment,
   required this.commentAvatar,
   required this.commentUsername,
   required this.comment,
   required this.commentedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      idUser: json['idUser'],
      idPost: json['idPost'],
      idComment: json['idComment'],
      commentAvatar: json['commentAvatar'],
      commentUsername: json['commentUsername'],
      comment: json['comment'],
      commentedAt: json['commentedAt'],
    );
  }
}