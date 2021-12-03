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
      state.copyWith(
        email: email,
        emailValid: valid,
      ),
    );
  }

  Future<void> passwordChanged({required String password}) async {
    bool valid = await _authRepository.isPasswordValid(password: password);
    emit(
      state.copyWith(
        password: password,
        passwordValid: valid,
      ),
    );
  }

  Future<void> submit({required String email, required String password}) async {
    emit(
      state.copyWith(
        email: email,
        password: password,
        formStatus: FormStatusSubmitting(),
      ),
    );
    try {
      await _authRepository.login(email: email, password: password);
      emit(
        state.copyWith(
          email: email,
          password: password,
          formStatus: FormStatusSuccess(),
        ),
      );
    } catch (ex) {
      emit(
        state.copyWith(
          email: email,
          password: password,
          formStatus: FormStatusFailure(exception: ex as Exception),
        ),
      );
    }
  }
}
