import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:shopping_app/feature/category/view/screens/products_by_category_screen.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/home/domain/entities/category_entity.dart';

class CategoriesListWidget extends StatefulWidget {
  const CategoriesListWidget({super.key, required this.categories});

  final List<CategoryItemEntity> categories;

  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}
class _CategoriesListWidgetState extends State<CategoriesListWidget> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              selectedIndex = index;
              setState(() {});
              final cleanSlug = widget.categories[index].slug;
              if (!mounted) return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: context.read<FavoriteCubit>()),
                      BlocProvider.value(value: context.read<CartCubit>()),
                    ],
                    child: ProductsByCategoryScreen(
                      slug: cleanSlug,
                      categoryName: widget.categories[index].name,
                    ),
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: isSelected
                      ? Colors.black
                      : Theme.of(context).hintColor,width: 1.25
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                widget.categories[index].name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 15),
        itemCount: widget.categories.length,
      ),
    );
  }
}
