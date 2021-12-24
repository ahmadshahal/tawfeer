import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit() : super(DeleteProductInitial());

  final ProductsRepository _productsRepository = ProductsRepository();

  Future<void> deleteProduct(/*{required int id}*/) async {
    try {
      emit(DeleteProductLoading());
      await _productsRepository.deleteProduct(id: 1);
      emit(DeleteProductSuccess());
    }
    catch(ex) {
      emit(DeleteProductFailure(exception: ex as Exception));
    }
  }
}
