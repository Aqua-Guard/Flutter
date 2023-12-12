class Partenaire {
  final String id;
  final String firstName;
  final String LastName;

  Partenaire({
    required this.id,
    required this.firstName,
    required this.LastName,
  });

  factory Partenaire.fromJson(Map<String, dynamic> json) {
    return Partenaire(
        id: json['id'],
        firstName: json['firstName'],
        LastName: json['lastName']);
  }
}
