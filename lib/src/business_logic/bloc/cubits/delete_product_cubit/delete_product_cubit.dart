import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit() : super(DeleteProductInitial());

  final ProductsRepository _productsRepository = ProductsRepository();

  Future<void> deleteProduct({required int id}) async {
    emit(DeleteProductLoading());
    try {
      await _productsRepository.deleteProduct(id: id);
      if (isClosed) return;
      emit(DeleteProductSuccess());
    } on Exception catch (ex) {
      if (isClosed) return;
      emit(DeleteProductFailure(exception: ex));
    }
  }
}
