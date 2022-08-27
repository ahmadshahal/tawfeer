part of 'edit_product_cubit.dart';

@immutable
abstract class EditProductState {}

class EditProductInitial extends EditProductState {}

class EditProductSubmitting extends EditProductState {}

class EditProductSuccess extends EditProductState {}

class EditProductFailure extends EditProductState {
  final TawfeerException exception;

  EditProductFailure({required this.exception});
}

