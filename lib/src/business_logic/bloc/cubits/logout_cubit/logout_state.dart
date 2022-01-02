part of 'logout_cubit.dart';

@immutable
abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutSubmitting extends LogoutState {}

class LogoutSuccess extends LogoutState {}

class LogoutFailure extends LogoutState {
  final TawfeerException exception;

  LogoutFailure({required this.exception});
}
