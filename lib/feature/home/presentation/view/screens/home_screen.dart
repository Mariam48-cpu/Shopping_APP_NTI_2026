import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';

import '../../../../../core/widgets/product_item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductItemEntity productItemEntity = ProductItemEntity();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi!,", style: Theme.of(context).textTheme.bodyLarge),
              Text(
                "Let’s start your day",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 20),
              CategoriesListWidget(),
              SizedBox(height: 20),

              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(top: 5, left: 8, right: 8),
                  itemCount: ApiConstants.productList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    var product = ApiConstants.productList[index];
                    return ProductItemCard(product: product);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
