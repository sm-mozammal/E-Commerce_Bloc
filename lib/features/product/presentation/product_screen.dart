import 'package:ecommerce_bloc/common_wigdets/loading_indicators.dart';
import 'package:ecommerce_bloc/features/product/bloc/product_bloc.dart';
import 'package:ecommerce_bloc/features/product/bloc/product_event.dart';
import 'package:ecommerce_bloc/features/product/bloc/product_state.dart';
import 'package:ecommerce_bloc/features/product/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch event to fetch products
    context.read<ProductBloc>().add(ProductFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          if (state is ProductLoadingState) {
            return loadingIndicatorCircle(context: context);
          } else if (state is ProductErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is ProductFetchState) {
            return GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.68,
              ),
              itemCount: state.productResponse.length,
              itemBuilder: (context, index) {
                final product = state.productResponse[index];
                return ProductCard(
                  productName: product.name ?? '',
                  price: product.price!,
                  imageUrl:
                      'https://i.chaldn.com/_mpimage/cooking?src=https%3A%2F%2Feggyolk.chaldal.com%2Fapi%2FPicture%2FRaw%3FpictureId%3D118865&q=best&v=1', // Placeholder image
                );
              },
            );
          } else {
            return loadingIndicatorCircle(context: context);
          }
        }),
      ),
    );
  }
}
