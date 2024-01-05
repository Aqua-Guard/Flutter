

        




class Discution {
  final String idmessage;
  final String idreclamation;
  final String message;
  final String userRole;
  final String createdAt;
  final bool  visibility;

  Discution({
    required this.idmessage,
    required this.idreclamation,
    required this.message,
    required this.userRole,
    required this.createdAt,
    required this.visibility,

  });

  factory Discution.fromJson(Map<String, dynamic> json) {
    return Discution(
      idmessage: json['idmessage'],
      idreclamation: json['idreclamation'],
      message: json['message'],
      userRole: json['userRole'],
      createdAt: json['createdAt'],
      visibility: json['visibility'],

    );
  }
}
