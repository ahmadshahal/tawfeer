import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/login_cubit/form_status.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState(email: '', password: ''));
  final AuthRepository _authRepository = AuthRepository();

  Future<void> submit({required String email, required String password}) async {
    emit(
      LoginState(
        email: email,
        password: password,
        emailValid: state.emailValid,
        passwordValid: state.passwordValid,
        formStatus: FormStatusSubmitting(),
      ),
    );
    bool isEmailValid = await _authRepository.isEmailValid(email: email);
    bool isPasswordValid = await _authRepository.isPasswordValid(password: password);
    if (isEmailValid && isPasswordValid) {
      try {
        await _authRepository.login(email: email, password: password);
        emit(
          LoginState(
            email: email,
            password: password,
            emailValid: isEmailValid,
            passwordValid: isPasswordValid,
            formStatus: FormStatusSuccess(),
          ),
        );
      } catch (ex) {
        emit(
          LoginState(
            email: email,
            password: password,
            emailValid: isEmailValid,
            passwordValid: isPasswordValid,
            formStatus: FormStatusFailure(exception: ex as Exception),
          ),
        );
      }
    } else {
      emit(
        LoginState(
          email: email,
          password: password,
          emailValid: isEmailValid,
          passwordValid: isPasswordValid,
          formStatus: FormStatusFailure(
              exception: Exception('Wrong Email or Password')),
        ),
      );
    }
  }
}
