class LoginResponse {
  String? id;
  String? username;
  String? image;
  int? nbPts;
  String? role;
  String? email;
  bool? isActivated;
  String? token;

  LoginResponse(
      {this.id,
        this.username,
        this.image,
        this.nbPts,
        this.role,
        this.email,
        this.isActivated,
        this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    image = json['image'];
    nbPts = json['nbPts'];
    role = json['role'];
    email = json['email'];
    isActivated = json['isActivated'];
    token = json['token'];
  }
}