import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/domain/entities/product_item_entity.dart';

import '../../../../../core/widgets/product_item_card.dart';
import '../../../widgets/categories_list_widget.dart';

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

