class Event {
  final DateTime dateDebut;
  final DateTime dateFin;
  final String eventName;
  final String description;
  final String lieu;
  final String userImage;
  final String userName;
  final String eventImage;
  final List<Map<String, dynamic>> participants;


  Event({
    required this.dateDebut,
    required this.dateFin,
    required this.eventName,
    required this.description,
    required this.lieu,
    required this.userImage,
    required this.userName,
    required this.eventImage,
    required this.participants,
  });

}
