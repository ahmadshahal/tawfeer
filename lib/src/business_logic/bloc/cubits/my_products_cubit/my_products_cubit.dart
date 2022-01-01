import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';

part 'my_products_state.dart';

class MyProductsCubit extends Cubit<MyProductsState> {
  MyProductsCubit() : super(MyProductsInitial());

  final ProductsRepository _productsRepository = ProductsRepository();

  Future<void> fetchData() async {
    try{
      List<Product> list = await _productsRepository.myProducts();
      if(isClosed) return;
      emit(MyProductsSuccess(list: list));
    }catch(ex) {
      if(isClosed) return;
      emit(MyProductsFailure(exception: ex as Exception));
    }
  }
}
