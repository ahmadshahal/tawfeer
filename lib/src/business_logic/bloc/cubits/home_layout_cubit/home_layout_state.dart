part of 'home_layout_cubit.dart';

@immutable
abstract class HomeLayoutState {
  const HomeLayoutState();
}

class HomeLayoutInitial extends HomeLayoutState {}

class HomeLayoutSuccess extends HomeLayoutState {
  final List<Product> list;
  const HomeLayoutSuccess({required this.list});
}

class HomeLayoutFailure extends HomeLayoutState {
  final Exception exception;
  const HomeLayoutFailure({required this.exception});
}
