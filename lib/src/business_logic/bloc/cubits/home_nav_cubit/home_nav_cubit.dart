import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_nav_state.dart';

class HomeNavCubit extends Cubit<HomeNavState> {
  HomeNavCubit() : super(const HomeNavState(index: 0));

  void changeIndex({required int index}) {
    emit(HomeNavState(index: index));
  }
}
