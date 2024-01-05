
class Reclamation {
 final String idreclamation;
  final String userId;
  final String title;
  final String image;
  final String date;
  final String description;

  Reclamation({
     required this.idreclamation,
    required this.userId,
    required this.title,
    required this.description,
    required this.image,
    required this.date,

  });

  factory Reclamation.fromJson(Map<String, dynamic> json) {
    return Reclamation(
      idreclamation: json['idreclamation'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      date: json['date'],

    );
  }
}
