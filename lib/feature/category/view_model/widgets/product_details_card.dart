import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/view_model/favorite_state.dart';

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
    final images = widget.product.images.isNotEmpty
        ? widget.product.images
        : [dummyImage];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Container(
                  color: Colors.grey.shade100,
                  child: CarouselSlider(
                    items: images.map((image) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.network(
                          image,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      height: double.infinity,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                  ),
                ),

                Positioned(
                  top: 16,
                  right: 16,
                  child: BlocBuilder<FavoriteCubit, FavoriteStates>(
                    builder: (context, state) {
                      final cubit = context.read<FavoriteCubit>();

                      return Material(
                        color: Colors.white,
                        elevation: 4,
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            cubit.toggleFavorite(widget.product.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              cubit.isFavorite(widget.product.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              size: 22,
                            ),
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

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentImageIndex == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentImageIndex == index
                    ? AppColors.primaryOrange
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          widget.product.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Text(
              "EGP ${widget.product.price.toStringAsFixed(0)}",
              style: const TextStyle(
                color: AppColors.primaryOrange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            const Icon(Icons.star_rounded, color: Colors.amber, size: 22),

            const SizedBox(width: 4),

            Text(
              widget.product.rating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}

const String dummyImage = "https://picsum.photos/200";
