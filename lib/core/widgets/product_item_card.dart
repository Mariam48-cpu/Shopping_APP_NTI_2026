import 'package:flutter/material.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavorite,
    this.isFavorite = false,
    this.imageOnlyClickable = false,
  });

  final ProductItemEntity product;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  /// لو true يبقى الضغط على الصورة فقط يفتح الـ Details
  final bool imageOnlyClickable;

  @override
  Widget build(BuildContext context) {
    final originalPrice =
        product.price / (1 - (product.discountPercentage / 100));

    Widget imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        product.images.isNotEmpty ? product.images.first : dummyImage,
        width: double.infinity,
        height: 238,
        fit: BoxFit.contain,
      ),
    );

    if (imageOnlyClickable) {
      imageWidget = GestureDetector(onTap: onTap, child: imageWidget);
    }

    Widget card = SizedBox(
      width: 168,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              imageWidget,

              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: onFavorite,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              Text(
                "EG ${product.price.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 6),

              Text(
                "EG ${originalPrice.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),

              const Spacer(),
            ],
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              Text(
                "-${product.discountPercentage.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),

              const Spacer(),

              const Icon(Icons.star, color: Colors.amber, size: 16),

              const SizedBox(width: 4),

              Text(
                product.rating.toStringAsFixed(1),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );

    if (!imageOnlyClickable) {
      card = GestureDetector(onTap: onTap, child: card);
    }

    return card;
  }
}

const String dummyImage = 'https://picsum.photos/200';
