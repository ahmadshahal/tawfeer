part of 'add_product_cubit.dart';

@immutable
abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductSubmitting extends AddProductState {}

class AddProductSuccess extends AddProductState {}

class AddProductFailure extends AddProductState {
  final TawfeerException exception;

  AddProductFailure({required this.exception});
}

