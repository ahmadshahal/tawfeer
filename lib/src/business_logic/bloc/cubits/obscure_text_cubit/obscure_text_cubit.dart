import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'obscure_text_state.dart';

class ObscureTextCubit extends Cubit<ObscureTextState> {
  ObscureTextCubit() : super(const ObscureTextState(obscureText: true));

  void changeObscureValue({required bool value}) {
    emit(ObscureTextState(obscureText: value));
  }
}
