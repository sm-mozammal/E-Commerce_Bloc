import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LogedInEvent extends LoginEvent {
  final String email;
  final String password;

  const LogedInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LogOutEvent extends LoginEvent {
  const LogOutEvent();

  @override
  List<Object?> get props => [];
}
