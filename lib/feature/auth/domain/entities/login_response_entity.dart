class LoginResponseEntity {
  String message;
  String token;
  UserEntity user;

  LoginResponseEntity({
    this.message = "",
    this.token = "",
    this.user = const UserEntity(),
  });
}

class UserEntity {
  final String name;
  final String phone;
  final String email;
  final String role;
  final String image;

  const UserEntity({
    this.name = "",
    this.phone = "",
    this.email = "",
    this.role = "",
    this.image = "",
  });
}