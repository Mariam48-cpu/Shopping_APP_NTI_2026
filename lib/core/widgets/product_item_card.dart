import 'package:flutter/material.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavorite,
    this.isFavorite = false,
  });

  final ProductItemEntity product;
  final void Function()? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 168,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Stack(
              children: [
                ClipRRect(
                  child: Image.network(
                    product.images.isNotEmpty
                        ? product.images.first
                        : dummyImage,
                    width: double.infinity,
                    height: 238,
                    fit: BoxFit.contain,
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: onFavorite,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              product.title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "EGP ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: product.price.toStringAsFixed(0),
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String dummyImage = 'https://picsum.photos/200';
