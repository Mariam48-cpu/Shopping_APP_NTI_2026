class CategoryEntity {
  final List<CategoryItemEntity> list;

  const CategoryEntity({
    this.list = const [], String? slug,
  });
}

class CategoryItemEntity {
  final String slug;
  final String name;
  final String url;
  final String image;

  const CategoryItemEntity({
    this.slug = '',
    this.name = '',
    this.url = '',
    this.image = '',
  });
}