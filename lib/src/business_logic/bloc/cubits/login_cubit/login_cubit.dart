import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final AuthRepository _authRepository = AuthRepository();

  Future<void> submit({required String email, required String password}) async {
    emit(LoginSubmitting());
    try {
      await _authRepository.login(email: email, password: password);
      emit(LoginSuccess());
    } catch (ex) {
      emit(LoginFailure(exception: ex as Exception));
    }
  }
}
