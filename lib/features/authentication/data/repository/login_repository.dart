import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce_bloc/features/authentication/data/model/login_response.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class LoginRepository {
  static final LoginRepository _singleton = LoginRepository._internal();
  LoginRepository._internal();
  static LoginRepository get instance => _singleton;

  Future<LoginResponse> login(String email, String password) async {
    try {
      Map data = {
        "email": email,
        "password": password,
      };

      Response response = await postHttp(Endpoints.logIn(), data);

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        LoginResponse data =
            LoginResponse.fromJson(json.decode(json.encode(response.data)));
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
