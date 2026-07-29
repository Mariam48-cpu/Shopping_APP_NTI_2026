import 'package:shopping_app/core/model/item/product_item_entity.dart';

class CartEntity {
  final List<ProductItemEntity> list;
  const CartEntity({required this.list});
}
