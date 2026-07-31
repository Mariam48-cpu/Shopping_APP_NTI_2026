import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';

import '../../../../core/theme/app_colors.dart';

class ProductDetailsCard extends StatefulWidget {
  final ProductItemEntity product;

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
        : [dummyImage];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: BlocBuilder<FavoriteCubit, FavoriteStates>(
                    builder: (context, state) {
                      final favoriteCubit = context.read<FavoriteCubit>();

                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            favoriteCubit.toggleFavorite(widget.product.id);
                          },
                          icon: Icon(
                            favoriteCubit.isFavorite(widget.product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
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
                widget.product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "EGP ${widget.product.price.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

const String dummyImage = 'https://picsum.photos/200';
