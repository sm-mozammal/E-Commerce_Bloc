import 'dart:developer';
import 'package:ecommerce_bloc/features/authentication/bloc/login_event.dart';
import 'package:ecommerce_bloc/features/authentication/bloc/login_state.dart';
import 'package:ecommerce_bloc/features/authentication/data/model/login_response.dart';
import 'package:ecommerce_bloc/features/authentication/data/repository/login_repository.dart';
import 'package:ecommerce_bloc/helpers/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepo = LoginRepository.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LogedInEvent>(loginSubmit);
  }

  Future<void> loginSubmit(LogedInEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      LoginResponse login = await loginRepo.login(event.email, event.password);
      ToastUtil.showLongToast(login.message!);
      emit(LoginSuccessfull(loginResponse: login));
    } catch (e) {
      log('Error Message: ${e.toString()}');
    }
  }
}
