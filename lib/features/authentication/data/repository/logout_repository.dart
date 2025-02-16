import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';

final class LogoutRepository {
  static final LogoutRepository _singleton = LogoutRepository._internal();
  LogoutRepository._internal();
  static LogoutRepository get instance => _singleton;

  Future<Map> logout() async {
    try {
      Response response = await postHttp(Endpoints.logout());

      log('response status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        Map data = json.decode(json.encode(response.data));
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
