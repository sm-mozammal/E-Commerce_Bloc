import 'package:ecommerce_bloc/features/authentication/data/model/login_response.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessfull extends LoginState {
  final LoginResponse loginResponse;

  const LoginSuccessfull({required this.loginResponse});

  @override
  List<Object?> get props => [loginResponse];
}

class LoginError extends LoginState {
  final String errorMessage;

  const LoginError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
