import 'dart:async';
import 'dart:developer';

import 'package:ecommerce_bloc/common_wigdets/custom_textfiled.dart';
import 'package:ecommerce_bloc/common_wigdets/loading_indicators.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_bloc.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_event.dart';
import 'package:ecommerce_bloc/features/product/bloc/product_bloc.dart';
import 'package:ecommerce_bloc/features/product/bloc/product_event.dart';
import 'package:ecommerce_bloc/features/product/bloc/product_state.dart';
import 'package:ecommerce_bloc/features/product/presentation/widgets/bottomsheet_widget.dart';
import 'package:ecommerce_bloc/features/product/presentation/widgets/product_card.dart';
import 'package:ecommerce_bloc/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductFetchEvent());
    searchController.addListener(_sinkLatestValue);
  }

  void _sinkLatestValue() {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      final searchText = searchController.text.trim();
      if (searchText.isNotEmpty) {
        context.read<ProductBloc>().add(ProductSearchEvent(searchText));
      } else {
        context.read<ProductBloc>().add(ProductSearchEvent(searchText));
      }
    });
  }

  @override
  void dispose() {
    searchController.clear();
    _debounceTimer?.cancel();
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
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          searchController.clear();
          context.read<ProductBloc>().add(ProductFetchEvent());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextFormField(
                  suffixIcon: Icons.cancel,
                  onSuffixIconTap: () {
                    searchController.clear();
                    context.read<ProductBloc>().add(ProductSearchEvent(''));
                  },
                  isPrefixIcon: false,
                  hintText: 'Search',
                  controller: searchController,
                ),
                BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
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
                      // scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.62,
                      ),
                      itemCount: state.productResponse.length,
                      itemBuilder: (context, index) {
                        final product = state.productResponse[index];
                        log(':${product.stockQty}');
                        return ProductCard(
                          stockAQuantiy: product.stockQty ?? '',
                          pack: product.packSize ?? '',
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
                UIHelper.verticalSpaceLarge,
                UIHelper.verticalSpaceLarge,
                UIHelper.verticalSpaceLarge,
              ],
            ),
          ),
        ),
      ),
      bottomSheet: BootomSheetwidget(),
    );
  }
}
