part of 'product_cubit.dart';

@immutable
abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {}

class ProductSuccess extends ProductState {
  final Product product;
  final User owner;
  const ProductSuccess({required this.product, required this.owner});
}

class ProductFailure extends ProductState {
  final Exception exception;
  const ProductFailure({required this.exception});
}
