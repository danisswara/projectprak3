class UserModel {
  final String id;
  final String email;
  final String username;
  final String password;
  final String role;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.role,
  });

  factory UserModel.fromJson(data, {required Map<String, dynamic> json}) => UserModel(
        id: json['id_login'],
        email: json['email'],
        username: json['username'],
        password: json['password'],
        role: json['role'],
      );
}
