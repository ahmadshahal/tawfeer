import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/auth_repository.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/user_repository.dart';
import 'package:tawfeer/src/business_logic/shared/my_user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  Future<void> submit({required String email, required String password}) async {
    emit(LoginSubmitting());
    try {
      // TODO: should return id or token.
      await _authRepository.login(email: email, password: password);
      MyUser.myUser = await _userRepository.fetchUser(id: 1);
      emit(LoginSuccess());
    } catch (ex) {
      emit(LoginFailure(exception: ex as Exception));
    }
  }
}
