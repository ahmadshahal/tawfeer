import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/user_repository.dart';
import 'package:tawfeer/src/business_logic/utils/exceptions.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  final UserRepository _userRepository = UserRepository();

  Future<void> logout() async {
    emit(LogoutSubmitting());
    try {
      await _userRepository.logout();
      if (isClosed) return;
      emit(LogoutSuccess());
    } on TawfeerException catch (ex) {
      if (isClosed) return;
      emit(LogoutFailure(exception: ex));
    }
  }
}
