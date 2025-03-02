import 'dart:developer';

import 'package:ecommerce_bloc/features/checkout/bloc/checkout_bloc.dart';
import 'package:ecommerce_bloc/features/checkout/bloc/checkout_event.dart';
import 'package:ecommerce_bloc/features/checkout/bloc/checkout_state.dart';
import 'package:ecommerce_bloc/helpers/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_bloc/common_wigdets/loading_indicators.dart';
import 'package:ecommerce_bloc/constants/app_colors.dart';
import 'package:ecommerce_bloc/helpers/responsive_utils.dart';
import 'package:ecommerce_bloc/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String pack;
  final String price;
  final int? originalPrice;
  final String imageUrl;
  final String stockAQuantiy;

  const ProductCard({
    super.key,
    required this.productName,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.pack,
    required this.stockAQuantiy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              _imageSection(),
              UIHelper.verticalSpaceSmall,

              // Product Name
              Text(
                productName,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              UIHelper.verticalSpaceSmall,

              _productPrice(),
              UIHelper.verticalSpaceSmall,

              Text(
                'Pack Size: $pack',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              UIHelper.verticalSpaceSmall,

              Text(
                'SQ: $stockAQuantiy',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              UIHelper.verticalSpaceSmall,

              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  int quantity = 0;

                  if (state is CartLoadedState) {
                    final item = state.cartItems.firstWhere(
                        (item) => item.productName == productName,
                        orElse: () => CartItem(
                            stockQuantity: stockAQuantiy,
                            productName: productName,
                            price: price,
                            imageUrl: imageUrl,
                            quantity: 0));
                    quantity = item.quantity;
                  }

                  return stockAQuantiy != '0.00'
                      ? quantity == 0
                          ? _addToBag(context)
                          : _addToBagQuantity(context, quantity, stockAQuantiy)
                      : Text('Out of Stock');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _addToBagQuantity(
      BuildContext context, int quantity, String stockQuantity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            context.read<CartBloc>().add(UpdateCartQuantityEvent(
                  stockQuantity: stockAQuantiy,
                  productName: productName,
                  quantity: quantity - 1,
                ));
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
            controller: TextEditingController(text: quantity.toString()),
            keyboardType: TextInputType.number,
            onSubmitted: (value) {
              log(' stockQuantity: $stockQuantity');

              int availableStock = int.parse(stockAQuantiy.split('.').first);

              final int? newQuantity = int.tryParse(value);
              log(' message:${(newQuantity != null && newQuantity <= availableStock)}');
              log(' message:$newQuantity $availableStock');
              if (newQuantity != null && newQuantity <= availableStock) {
                if (newQuantity > 0) {
                  context.read<CartBloc>().add(
                        UpdateCartQuantityEvent(
                          productName: productName,
                          stockQuantity: stockAQuantiy,
                          quantity: newQuantity,
                        ),
                      );
                }
              } else {
                ToastUtil.showLongToast('Out Of Stock');
              }
            },
          ),
        ),
        IconButton(
          onPressed: () {
            // Check Stoce
            int availableStock = int.parse(stockAQuantiy.split('.').first);
            if (quantity + 1 <= availableStock) {
              context.read<CartBloc>().add(UpdateCartQuantityEvent(
                    stockQuantity: stockAQuantiy,
                    productName: productName,
                    quantity: quantity + 1,
                  ));
            } else {
              ToastUtil.showLongToast('Out Of Stock');
            }
          },
          icon: const Icon(Icons.add, color: Colors.red),
        ),
      ],
    );
  }

  Center _addToBag(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<CartBloc>().add(AddToCartEvent(
                stockQuantity: stockAQuantiy,
                productName: productName,
                price: price,
                imageUrl: imageUrl,
                quantity: 1,
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.allPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Add to Bag'),
      ),
    );
  }

  Row _productPrice() {
    return Row(
      children: [
        Text(
          '৳$price',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        if (originalPrice != null) ...[
          const SizedBox(width: 8),
          Text(
            '৳$originalPrice',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }

  CachedNetworkImage _imageSection() {
    return CachedNetworkImage(
      width: double.infinity,
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      height: SizeConfig.height(10),
      placeholder: (context, url) => shimmer(context: context),
    );
  }
}
