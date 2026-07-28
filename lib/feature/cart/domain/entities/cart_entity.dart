import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/feature/cart/data/dto/cart_dto.dart';

class CartEntity {
  final List<ProductItemEntity> list;

  const CartEntity({required this.list});
  factory CartEntity.fromDto(CartDto dto) {
    return CartEntity(
      list: dto.list?.first.list?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
