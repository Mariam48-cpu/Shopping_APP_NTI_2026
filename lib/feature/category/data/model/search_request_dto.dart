import 'package:shopping_app/feature/category/domain/entities/search_request_entity.dart';

class SearchRequestDto {
  String? search;
  int? skip;
  int? limit;

  SearchRequestDto({this.search, this.skip, this.limit});

  SearchRequestDto.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['search'] = search;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }

  SearchRequestEntity toEntity(){
    return SearchRequestEntity(
      search: search??'',
      skip: skip??0,
      limit: limit??5,
    );
  }

  }
