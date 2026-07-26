import 'package:flutter/material.dart';

class CategoriesListWidget extends StatefulWidget {
  const CategoriesListWidget({super.key});

  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}

class _CategoriesListWidgetState extends State<CategoriesListWidget> {
  List<String> categories = [
    'Miscellaneous',
    'Shoes',
    'Furniture',
    'Electronics',
    'T-shirts',
  ];
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
                categories[index],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemCount: categories.length,
      ),
    );
  }
}
