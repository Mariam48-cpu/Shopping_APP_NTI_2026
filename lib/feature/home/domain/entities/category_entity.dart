
import 'package:shopping_app/feature/home/data/dto/category_dto.dart';

class CategoryEntity {
  final int? id;
  final String? name;
  final String? slug;
  final String? image;

  const CategoryEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
  });
    CategoryDto toDto() {
    return CategoryDto(
      id: id,
      name: name,
      slug: slug,
      image: image,
    );
  }
    factory CategoryEntity.fromDto(CategoryDto dto) {
    return CategoryEntity(
      id: dto.id,
      name: dto.name,
      slug: dto.slug,
      image: dto.image,
    );
  }
}