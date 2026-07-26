import 'package:flutter/material.dart';
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
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: isSelected
                      ? Colors.black
                      : Theme.of(context).hintColor,
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
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemCount: widget.categories.length,
      ),
    );
  }
}
