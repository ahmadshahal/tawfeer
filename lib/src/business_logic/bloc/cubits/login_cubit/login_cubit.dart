import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/user_repository.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/business_logic/utils/exceptions.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final UserRepository _userRepository = UserRepository();

  Future<void> submit({required String email, required String password}) async {
    emit(LoginSubmitting());
    try {
      Shared.token = await _userRepository.login(
        email: email,
        password: password,
      );
      Shared.pref.setString('token', Shared.token!);
      Shared.myUser = await _userRepository.profile();
      if (isClosed) return;
      emit(LoginSuccess());
    } on TawfeerException catch (ex) {
      if (isClosed) return;
      emit(LoginFailure(exception: ex));
    }
  }
}
