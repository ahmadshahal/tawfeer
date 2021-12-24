part of 'delete_product_cubit.dart';

@immutable
abstract class DeleteProductState {}

class DeleteProductInitial extends DeleteProductState {}

class DeleteProductLoading extends DeleteProductState {}

class DeleteProductSuccess extends DeleteProductState {}

class DeleteProductFailure extends DeleteProductState {
  final Exception exception;
  DeleteProductFailure({required this.exception});
}
