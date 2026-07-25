
import 'package:shopping_app/feature/home/domain/entities/category_entity.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final CategoryEntity categories;

  CategorySuccess({required this.categories});
}

final class CategoryError extends CategoryState {
  final String message;

  CategoryError({required this.message});
}