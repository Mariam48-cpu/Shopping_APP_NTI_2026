import '../../domain/entities/product_entity.dart';
import 'category_dto.dart';

class ProductDto {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  CategoryDto? category;
  List<String>? images;

  ProductDto({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      price: json['price'],
      description: json['description'],
      category: json['category'] != null
          ? CategoryDto.fromJson(json['category'])
          : null,
      images: List<String>.from(json['images']),
    );
  }

  factory ProductDto.fromEntity(ProductEntity entity) {
    return ProductDto(
      id: entity.id,
      title: entity.title,
      slug: entity.slug,
      price: entity.price,
      description: entity.description,
      category: entity.category?.toDto(),
      images: entity.images,
    );
  }
}