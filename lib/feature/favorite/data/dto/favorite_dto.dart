import 'package:shopping_app/core/model/item/product_item_dto.dart';
import 'package:shopping_app/feature/favorite/domain/entities/favorite_entity.dart';

class FavoriteDto {
  List<ProductItemDto> list = [];
  FavoriteDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] == null) return;
    for (final item in json['list']) {
      if (item['list'] != null) {
        list.addAll(
          (item['list'] as List)
              .map((e) => ProductItemDto.fromJson(e))
              .toList(),
        );
      } else {
        list.add(ProductItemDto.fromJson(item));
      }
    }
  }

  FavoriteEntity toEntity() {
    return FavoriteEntity(productList: list);
  }
}
