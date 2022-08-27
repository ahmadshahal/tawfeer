import 'package:bloc/bloc.dart';

class ExpireDateCubit extends Cubit<bool> {
  ExpireDateCubit() : super(false);

  void expireDateFilled() {
    emit(true);
  }
}
