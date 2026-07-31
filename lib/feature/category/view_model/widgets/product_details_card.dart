import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/feature/category/domain/entities/product_details_entity.dart';

import '../../../../core/theme/app_colors.dart';

class ProductDetailsCard extends StatefulWidget {
  final ProductDetailsEntity product;

  const ProductDetailsCard({super.key, required this.product});

  @override
  State<ProductDetailsCard> createState() => _ProductDetailsCardState();
}

class _ProductDetailsCardState extends State<ProductDetailsCard> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final imagesList = widget.product.images.isNotEmpty
        ? widget.product.images
        : [dummyImage, dummyImage, dummyImage];

    return Column(
      crossAxisAlignment: .start,
      children: [
        AspectRatio(
          aspectRatio: 343 / 331,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                CarouselSlider(
                  items: imagesList.map((imageUrl) {
                    return Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imagesList.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentImageIndex == index
                    ? const Color(0xFF2B2B2B)
                    : const Color(0xFFE2DFEC),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.product.title.isNotEmpty
                    ? widget.product.title
                    : "T-shirt oversize",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(width: 12),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "EGP ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryOrange,
                    ),
                  ),
                  TextSpan(
                    text: widget.product.price.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryOrange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String dummyImage = 'https://picsum.photos/200';
