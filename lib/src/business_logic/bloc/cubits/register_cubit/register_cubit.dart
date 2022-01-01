import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/auth_repository.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/user_repository.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final AuthRepository _authRepository = AuthRepository();
  final UserRepository _userRepository = UserRepository();

  Future<void> submit({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    emit(RegisterSubmitting());
    try {
      // TODO: should return id or token.
      await _authRepository.register(fullName: fullName, email: email, password: password, phoneNumber: phoneNumber);
      Shared.myUser = await _userRepository.fetchUser(id: 1);
      emit(RegisterSuccess());
    } catch (ex) {
      emit(RegisterFailure(exception: ex as Exception));
    }
  }
}
