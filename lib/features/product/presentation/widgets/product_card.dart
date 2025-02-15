import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_bloc/common_wigdets/loading_indicators.dart';
import 'package:ecommerce_bloc/constants/app_colors.dart';
import 'package:ecommerce_bloc/helpers/responsive_utils.dart';
import 'package:ecommerce_bloc/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String productName;
  final String price;
  final int? originalPrice;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.productName,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              width: double.infinity,
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
              height: SizeConfig.height(10),
              placeholder: (context, url) => shimmer(context: context),
            ),
            UIHelper.verticalSpaceMedium,
            Text(
              widget.productName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              children: [
                Text(
                  '৳${widget.price}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                if (widget.originalPrice != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    '৳${widget.originalPrice}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ],
            ),
            UIHelper.verticalSpaceMedium,
            quantity == 0
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        quantity = 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.allPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Add to Bag'),
                  )
                : Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 0) quantity--;
                          });
                        },
                        icon: const Icon(Icons.remove, color: Colors.red),
                      ),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                          ),
                          controller:
                              TextEditingController(text: quantity.toString()),
                          keyboardType: TextInputType.number,
                          onSubmitted: (value) {
                            final int? newQuantity = int.tryParse(value);
                            if (newQuantity != null && newQuantity >= 0) {
                              setState(() {
                                quantity = newQuantity;
                              });
                            }
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add, color: Colors.red),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
