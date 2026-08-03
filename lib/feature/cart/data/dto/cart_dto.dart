import 'package:shopping_app/core/model/item/product_item_dto.dart';
import 'package:shopping_app/feature/cart/domain/entities/cart_entity.dart';

class CartDto {
  final List<ProductItemDto> list;

  CartDto({required this.list});

  factory CartDto.fromJson(Map<String, dynamic> json) {
    return CartDto(
      list: (json['list'] as List<dynamic>?)
              ?.map((e) => ProductItemDto.fromJson(e))
              .toList() ??
          [],
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      list: list.map((e) => e.toEntity()).toList(),
    );
  }
}