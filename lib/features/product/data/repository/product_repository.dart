import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_bloc/features/product/data/model/product_response.dart';

import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class ProductRepository {
  static final ProductRepository _singleton = ProductRepository._internal();
  ProductRepository._internal();
  static ProductRepository get instance => _singleton;

  Future<List<ProductResponse>> product() async {
    try {
      Response response = await getHttp(Endpoints.product());

      if (response.statusCode == 200) {
        List<ProductResponse> data =
            productResponseFromJson(json.encode(response.data));
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
      // ErrorHandler.handle(error).failure.resonseCode;
    }
  }
}
