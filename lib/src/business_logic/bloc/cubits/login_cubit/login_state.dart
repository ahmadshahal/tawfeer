part of 'login_cubit.dart';


@immutable
class LoginState {
  final String email;
  final String password;
  final bool emailValid;
  final bool passwordValid;
  final FormStatus formStatus;

  const LoginState({
    required this.email,
    required this.password,
    this.emailValid = false,
    this.passwordValid = false,
    this.formStatus = const FormStatusInitial(),
  });
}


