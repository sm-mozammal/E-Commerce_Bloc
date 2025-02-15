import 'package:dio/dio.dart';
import 'package:ecommerce_bloc/features/product/bloc/product_event.dart';
import 'package:ecommerce_bloc/features/product/bloc/product_state.dart';
import 'package:ecommerce_bloc/features/product/data/model/product_response.dart';
import 'package:ecommerce_bloc/features/product/data/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  String errorMessage = 'Something Wants Wrong';
  ProductBloc() : super(ProductInitialState()) {
    on<ProductFetchEvent>(fetchProduct);
  }

  Future<void> fetchProduct(
      ProductFetchEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      List<ProductResponse> response =
          await ProductRepository.instance.product();
      emit(ProductFetchState(productResponse: response));
    } catch (e) {
      DioException error = e as DioException;
      if (error.type == DioExceptionType.connectionError) {
        errorMessage = "Check Your Network Connection";
      }
      emit(ProductErrorState(errorMessage: errorMessage));
    }
  }
}
