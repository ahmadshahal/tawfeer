part of 'product_cubit.dart';

@immutable
abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {}

class ProductSuccess extends ProductState {
  final Product product;
  final User owner;
  final List<Review> reviews;
  const ProductSuccess({required this.product, required this.owner, required this.reviews});
}

class ProductFailure extends ProductState {
  final TawfeerException exception;
  const ProductFailure({required this.exception});
}
