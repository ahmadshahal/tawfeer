part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSubmitting extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final TawfeerException exception;

  LoginFailure({required this.exception});
}
