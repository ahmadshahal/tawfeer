import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/user_repository.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final UserRepository _userRepository = UserRepository();

  Future<void> submit({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    emit(RegisterSubmitting());
    try {
      Shared.token = await _userRepository.register(
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
      );
      Shared.pref.setString('token', Shared.token!);
      Shared.myUser = await _userRepository.profile();
      if(isClosed) return;
      emit(RegisterSuccess());
    } on Exception catch (ex) {
      if(isClosed) return;
      emit(RegisterFailure(exception: ex));
    }
  }
}
