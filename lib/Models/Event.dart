class Event {
  final String idEvent;
  final String userName;
  final String userImage;
  final String eventName;
  final String description;
  final String eventImage;
  final DateTime dateDebut;
  final DateTime dateFin;
  final String lieu;
  bool hidden;
  final List<dynamic> participants;

  Event({
    required this.idEvent,
    required this.userName,
    required this.userImage,
    required this.eventName,
    required this.description,
    required this.eventImage,
    required this.dateDebut,
    required this.dateFin,
    required this.lieu,
    required this.hidden,
    required this.participants,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      idEvent: json['idEvent'],
      userName: json['userName'],
      userImage: json['userImage'],
      eventName: json['eventName'],
      description: json['description'],
      eventImage: json['eventImage'],
      dateDebut: DateTime.parse(json['DateDebut']),
      dateFin: DateTime.parse(json['DateFin']),
      lieu: json['lieu'],
      hidden: json['hidden'],
      participants: List<dynamic>.from(json['participants']),
    );
  }
}
