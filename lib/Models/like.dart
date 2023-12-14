class Like {
  final String likeAvatar;
  final String likeUsername;
 
  Like({
    required this.likeAvatar,
    required this.likeUsername,
  });
 factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      likeAvatar: json['likeAvatar'],
      likeUsername: json['likeUsername']
    );
  }
 
}
