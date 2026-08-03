import 'package:shopping_app/core/model/item/product_item_dto.dart';

class FavoriteEntity {
  final List<ProductItemDto> productList;

  const FavoriteEntity({required this.productList});
}
