class Actualite {
  final String userId;
  final String title;
  final String description;
  final String image;
  final String text;
  final num views; // Change the type to num or int
  final num like;
  final num dislike;

  Actualite({
    required this.userId,
    required this.title,
    required this.description,
    required this.image,
    required this.text,
    required this.views,
    required this.like,
    required this.dislike,
  });

  factory Actualite.fromJson(Map<String, dynamic> json) {
    return Actualite(
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      text: json['text'],
      views: json['views'],
      like: json['like'],
      dislike: json['dislike'],
    );
  }
}
