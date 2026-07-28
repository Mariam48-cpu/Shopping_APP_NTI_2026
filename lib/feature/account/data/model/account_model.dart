import '../../domain/entity/account_entity.dart';

class UserDataDto {
  MessageDto? message;

  UserDataDto({this.message});

  UserDataDto.fromJson(Map<String, dynamic> json) {
    message = json['message'] != null
        ?  MessageDto.fromJson(json['message'])
        : null;
  }
  AccountEntity toEntity() {
    return message?.toEntity() ?? AccountEntity();
  }
}

class MessageDto {
  String? sId;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? image;

  MessageDto({
    this.sId,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.image,
  });

  MessageDto.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    image = json['image'];
  }
  AccountEntity toEntity() {
    return AccountEntity(
      sId: sId ?? '',
      name: name ?? '',
      phone: phone ?? '',
      email: email ?? '',
      address: address ?? '',
      image: image ?? '',
    );
  }
}
