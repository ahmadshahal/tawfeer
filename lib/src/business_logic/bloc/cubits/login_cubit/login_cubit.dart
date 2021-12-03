import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/cubits/login_cubit/form_status.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState(email: '', password: ''));
  final AuthRepository _authRepository = AuthRepository();

  Future<void> emailChanged({required String email}) async {
    bool valid = await _authRepository.isEmailValid(email: email);
    emit(
      LoginState(
        email: email,
        password: state.email,
        emailValid: valid,
        passwordValid: state.passwordValid,
        formStatus: state.formStatus,
      ),
    );
  }

  Future<void> passwordChanged({required String password}) async {
    bool valid = await _authRepository.isPasswordValid(password: password);
    emit(
      LoginState(
        email: state.email,
        password: password,
        emailValid: state.emailValid,
        passwordValid: valid,
        formStatus: state.formStatus,
      ),
    );
  }

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
    try {
      await _authRepository.login(email: email, password: password);
      emit(
        LoginState(
          email: email,
          password: password,
          emailValid: state.emailValid,
          passwordValid: state.passwordValid,
          formStatus: FormStatusSuccess(),
        ),
      );
    } catch (ex) {
      emit(
        LoginState(
          email: email,
          password: password,
          emailValid: state.emailValid,
          passwordValid: state.passwordValid,
          formStatus: FormStatusFailure(exception: ex as Exception),
        ),
      );
    }
  }
}
