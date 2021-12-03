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

  LoginState copyWith({
    String? email,
    String? password,
    bool? emailValid,
    bool? passwordValid,
    FormStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailValid: emailValid ?? this.emailValid,
      passwordValid: passwordValid ?? this.passwordValid,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
