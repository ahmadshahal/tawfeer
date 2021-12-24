import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/user_repository.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/business_logic/models/user.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  final ProductsRepository _productsRepository = ProductsRepository();
  final UserRepository _userRepository = UserRepository();

  Future<void> fetchData() async {
    try {
      Product product = await _productsRepository.getProduct(id: 1);
      User user = await _userRepository.fetchUser(id: product.ownerId);
      emit(ProductSuccess(product: product, ownerEmail: user.email));
    } catch (ex) {
      emit(ProductFailure(exception: ex as Exception));
    }
  }
}
