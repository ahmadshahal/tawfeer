part of 'my_products_cubit.dart';

@immutable
abstract class MyProductsState {
  const MyProductsState();
}

class MyProductsInitial extends MyProductsState {}

class MyProductsSuccess extends MyProductsState {
  final List<Product> list;
  const MyProductsSuccess({required this.list});
}

class MyProductsFailure extends MyProductsState {
  final TawfeerException exception;
  const MyProductsFailure({required this.exception});
}
