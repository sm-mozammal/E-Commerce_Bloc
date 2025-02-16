import 'package:ecommerce_bloc/features/product/data/model/product_response.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

class ProductFetchState extends ProductState {
  final List<ProductResponse> productResponse;
  const ProductFetchState({required this.productResponse});

  @override
  List<Object?> get props => [productResponse];
}

class ProductSearchState extends ProductState {
  final List<ProductResponse> productResponse;
  const ProductSearchState({required this.productResponse});

  @override
  List<Object?> get props => [productResponse];
}

class ProductErrorState extends ProductState {
  final String errorMessage;
  const ProductErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
