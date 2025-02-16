import 'package:ecommerce_bloc/common_wigdets/custom_textfiled.dart';
import 'package:ecommerce_bloc/common_wigdets/loading_indicators.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_bloc.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_event.dart';
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
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Dispatch event to fetch products
    context.read<ProductBloc>().add(ProductFetchEvent());
    searchController.addListener(_sinkLatestValue);
  }

  void _sinkLatestValue() {
    if (searchController.text.isNotEmpty) {
      context
          .read<ProductBloc>()
          .add(ProductSearchEvent(searchController.text));
    }
  }

  @override
  void dispose() {
    searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: [
          InkWell(
            onTap: () {
              context.read<LoginBloc>().add(LogOutEvent());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.logout_outlined),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextFormField(
                isPrefixIcon: false,
                hintText: 'Search',
                controller: searchController,
              ),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                if (state is ProductLoadingState) {
                  return loadingIndicatorCircle(context: context);
                } else if (state is ProductErrorState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else if (state is ProductFetchState) {
                  if (state.productResponse.isEmpty) {
                    return Center(
                      child: Text('No Product Found'),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.7,
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
            ],
          ),
        ),
      ),
    );
  }
}
