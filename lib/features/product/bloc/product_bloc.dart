import 'package:dio/dio.dart';
import 'package:ecommerce_bloc/constants/app_constants.dart';
import 'package:ecommerce_bloc/features/product/bloc/product_event.dart';
import 'package:ecommerce_bloc/features/product/bloc/product_state.dart';
import 'package:ecommerce_bloc/features/product/data/model/product_response.dart';
import 'package:ecommerce_bloc/features/product/data/repository/product_repository.dart';
import 'package:ecommerce_bloc/helpers/all_routes.dart';
import 'package:ecommerce_bloc/helpers/di.dart';
import 'package:ecommerce_bloc/helpers/navigation_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  String errorMessage = 'Something Wants Wrong';
  List<ProductResponse> productResponse = [];
  ProductBloc() : super(ProductInitialState()) {
    on<ProductFetchEvent>(fetchProduct);
    on<ProductSearchEvent>(searchProduct);
  }

  Future<void> fetchProduct(
      ProductFetchEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      List<ProductResponse> response =
          await ProductRepository.instance.product();
      productResponse = response;
      emit(ProductFetchState(productResponse: response));
    } catch (e) {
      DioException error = e as DioException;
      if (error.response!.statusCode == 401) {
        await appData.write(kKeyIsLoggedIn, false);
        await appData.remove(kKeyAccessToken);
        NavigationService.navigateToUntilReplacement(Routes.loginScreen);
      }
      if (error.type == DioExceptionType.connectionError) {
        errorMessage = "Check Your Network Connection";
      } else {
        errorMessage = error.response!.data["message"];
      }
      emit(ProductErrorState(errorMessage: errorMessage));
    }
  }

  Future<void> searchProduct(
      ProductSearchEvent event, Emitter<ProductState> emit) async {
    // emit(ProductLoadingState());
    try {
      if (productResponse.isNotEmpty) {
        List<ProductResponse> filteredResponse = productResponse
            .where((prduct) =>
                prduct.name
                    ?.toLowerCase()
                    .contains(event.queary.toLowerCase()) ??
                false)
            .toList();
        emit(ProductFetchState(productResponse: filteredResponse));
      }
    } catch (e) {
      emit(ProductErrorState(errorMessage: e.toString()));
    }
  }
}
