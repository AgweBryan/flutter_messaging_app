class CustomUser {
  String? id;
  String? displayName;
  String? email;
  String? username;
  String? photoUrl;

  CustomUser({
    this.id,
    this.displayName,
    this.email,
    this.username,
    this.photoUrl,
  });

  static CustomUser fromJson(Map<String, dynamic> json) {
    return CustomUser(
      id: json['id'],
      displayName: json['displayName'],
      email: json['email'],
      username: json['username'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'username': username,
      'photoUrl': photoUrl,
    };
  }
}
