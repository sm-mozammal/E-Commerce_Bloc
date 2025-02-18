import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce_bloc/constants/app_constants.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_event.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_state.dart';
import 'package:ecommerce_bloc/features/authentication/data/model/login_response.dart';
import 'package:ecommerce_bloc/features/authentication/data/repository/login_repository.dart';
import 'package:ecommerce_bloc/features/authentication/data/repository/logout_repository.dart';
import 'package:ecommerce_bloc/helpers/all_routes.dart';
import 'package:ecommerce_bloc/helpers/di.dart';
import 'package:ecommerce_bloc/helpers/navigation_service.dart';
import 'package:ecommerce_bloc/helpers/toast.dart';
import 'package:ecommerce_bloc/networks/dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepo = LoginRepository.instance;
  LogoutRepository logoutRepo = LogoutRepository.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LogedInEvent>(loginSubmit);
    on<LogOutEvent>(logout);
  }

  Future<void> loginSubmit(LogedInEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      LoginResponse login = await loginRepo.login(event.email, event.password);
      await appData.write(kKeyIsLoggedIn, true);
      await appData.write(kKeyAccessToken, login.token);
      DioSingleton.instance.update(login.token!);
      emit(LoginSuccessfull(loginResponse: login));
    } catch (e) {
      log('Error Message: ${e.toString()}');

      DioException exception = e as DioException;
      emit(LoginError(errorMessage: exception.response!.data["message"]!));
    }
  }

  Future<void> logout(LogOutEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await logoutRepo.logout();
      await appData.write(kKeyIsLoggedIn, false);
      await appData.remove(kKeyAccessToken);
      ToastUtil.showLongToast('Successfully logged out');
      NavigationService.navigateToUntilReplacement(Routes.loginScreen);
      emit(LoginInitial());
    } catch (e) {
      log('Error Message: ${e.toString()}');
      DioException exception = e as DioException;
      emit(LoginError(errorMessage: exception.response!.data["message"]!));
    }
  }
}
