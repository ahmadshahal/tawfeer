import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/user_repository.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/business_logic/models/user.dart';
import 'package:tawfeer/src/business_logic/utils/exceptions.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  final ProductsRepository _productsRepository = ProductsRepository();
  final UserRepository _userRepository = UserRepository();

  Future<void> fetchData({required int id}) async {
    try {
      Product product = await _productsRepository.getProduct(id: id);
      User user = await _userRepository.fetchUser(id: product.ownerId);
      // If the cubit was Closed while fetching products or users.
      if(isClosed) return;
      emit(ProductSuccess(product: product, owner: user));
    } on TawfeerException catch (ex) {
      if(isClosed) return;
      emit(ProductFailure(exception: ex));
    }
  }
}
