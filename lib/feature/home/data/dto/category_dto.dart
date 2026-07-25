import 'package:shopping_app/feature/home/domain/entities/category_entity.dart';

class CategoryDto {
  List<CategoryItemDto>? list;

  CategoryDto({this.list});

  CategoryDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list!.add(CategoryItemDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (list != null) {
      data['list'] = list!.map((e) => e.toJson()).toList();
    }

    return data;
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      list: list?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class CategoryItemDto {
  String? slug;
  String? name;
  String? url;
  String? image;

  CategoryItemDto({
    this.slug,
    this.name,
    this.url,
    this.image,
  });

  CategoryItemDto.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    url = json['url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
      'image': image,
    };
  }

  CategoryItemEntity toEntity() {
    return CategoryItemEntity(
      slug: slug ?? '',
      name: name ?? '',
      url: url ?? '',
      image: image ?? '',
    );
  }
}