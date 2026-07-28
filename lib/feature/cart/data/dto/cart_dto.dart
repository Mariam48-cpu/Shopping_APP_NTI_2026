import 'package:shopping_app/core/model/item/product_item_dto.dart';
import 'package:shopping_app/feature/cart/domain/entities/cart_entity.dart';

class CartDto {
  List<CartListDto>? list;

  CartDto.fromJson(Map<String, dynamic> json) {
    list = (json['list'] as List)
        .map((e) => CartListDto.fromJson(e))
        .toList();
  }

CartEntity toEntity() {
  return CartEntity(
    list: list?.first.list?.map((e) => e.toEntity()).toList() ?? [],
  );
}
}
class CartListDto {
  List<ProductItemDto>? list;
  int? total;
  int? skip;
  int? limit;

  CartListDto.fromJson(Map<String, dynamic> json) {
    list = (json['list'] as List)
        .map((e) => ProductItemDto.fromJson(e))
        .toList();

    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
}