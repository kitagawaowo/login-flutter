class User {
  final int id;
  final String username;
  final String password;

  User({required this.id, required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'password': password};
  }

  User.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            username: json['username'],
            password: json['password']);
}
