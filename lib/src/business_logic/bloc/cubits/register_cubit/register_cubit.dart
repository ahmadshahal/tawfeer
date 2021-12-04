import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final AuthRepository _authRepository = AuthRepository();

  Future<void> submit({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    emit(RegisterSubmitting());
    try {
      await _authRepository.register(fullName: fullName, email: email, password: password, phoneNumber: phoneNumber);
      emit(RegisterSuccess());
    } catch (ex) {
      emit(RegisterFailure(exception: ex as Exception));
    }
  }
}
