class UpdateAccountDto {
  String? message;

  UpdateAccountDto({this.message});

  UpdateAccountDto.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
