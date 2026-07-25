import 'package:shopping_app/feature/home/data/dto/product_dto.dart';
import 'package:shopping_app/feature/home/domain/entities/category_entity.dart';

class ProductEntity {
  final int? id;
  final String? title;
  final String? slug;
  final int? price;
  final String? description;
  final CategoryEntity? category;
  final List<String>? images;

  const ProductEntity({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
  });

  factory ProductEntity.fromDto(ProductDto dto) {
    return ProductEntity(
      id: dto.id,
      title: dto.title,
      slug: dto.slug,
      price: dto.price,
      description: dto.description,
      category:
          dto.category != null ? CategoryEntity.fromDto(dto.category!) : null,
      images: dto.images,
    );
  }

  ProductDto toDto() {
    return ProductDto(
      id: id,
      title: title,
      slug: slug,
      price: price,
      description: description,
      category: category?.toDto(),
      images: images,
    );
  }
}