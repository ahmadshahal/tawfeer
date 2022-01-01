import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  final ProductsRepository _productsRepository = ProductsRepository();

  Future<void> submit({required Product product}) async {
    emit(AddProductSubmitting());
    try {
      await _productsRepository.addProduct(product: product);
      if(isClosed) return;
      emit(AddProductSuccess());
    }catch(ex) {
      if(isClosed) return;
      emit(AddProductFailure(exception: ex as Exception));
    }
  }
}
