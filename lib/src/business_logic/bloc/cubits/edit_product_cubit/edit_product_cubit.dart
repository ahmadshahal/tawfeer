import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit() : super(EditProductInitial());

  final ProductsRepository _productsRepository = ProductsRepository();

  Future<void> submit({required Product product}) async {
    emit(EditProductSubmitting());
    try {
      await _productsRepository.editProduct(product: product);
      if(isClosed) return;
      emit(EditProductSuccess());
    } on Exception catch(ex) {
      if(isClosed) return;
      emit(EditProductFailure(exception: ex));
    }
  }
}
