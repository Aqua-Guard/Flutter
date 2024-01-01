class UserResponse {
  String? id;
  String? username;
  String? image;
  String? firstName;
  String? lastName;
  int? nbPts;
  String? role;
  String? email;
  bool? isActivated;
  bool? isBlocked;
  DateTime? bannedUntil;

  UserResponse

  (

  this

      .

  id,
  this.username,
  this.image,
  this.nbPts,
  this.role,
  this.isBlocked,
  this.lastName,
  this.firstName,
  this.email,
  this.isActivated,
  this.bannedUntil);

  UserResponse.fromJson(Map<String, dynamic> json) {
  id = json['_id'];
  username = json['username'];
  isBlocked = json['isBlocked'];
  firstName = json['firstName'];
  lastName = json['lastName'];
  image = json['image'];
  nbPts = json['nbPts'];
  role = json['role'];
  email = json['email'];
  isActivated = json['isActivated'];
  bannedUntil = json['bannedUntil'] != null
  ? DateTime.parse(json['bannedUntil']) : null;
  }
}
