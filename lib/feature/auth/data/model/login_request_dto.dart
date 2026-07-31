import '../../domain/entities/login_response_entity.dart';

class LoginResponseDto {
  String? message;
  String? token;
  AppUserDto? user;

  LoginResponseDto({this.message, this.token, this.user});

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new AppUserDto.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }

  // to Entity
  LoginResponseEntity toEntity() {
    return LoginResponseEntity(
      message: message ?? "",
      token: token ?? "",
      user: user?.toEntity() ?? const UserEntity(),
    );
  }
}

class AppUserDto {
  String? name;
  String? phone;
  String? email;
  String? role;
  String? image;

  AppUserDto({this.name, this.phone, this.email, this.role, this.image});

  AppUserDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    image = json['image'];
  } 

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['role'] = this.role;
    data['image'] = this.image;
    return data;
  }

  UserEntity toEntity() {
    return UserEntity(
      name: name ?? "",
      phone: phone ?? "",
      email: email ?? "",
      role: role ?? "",
      image: image ?? "",
    );
  }
}