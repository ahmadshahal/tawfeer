import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/business_logic/shared/my_user.dart';

part 'my_products_state.dart';

class MyProductsCubit extends Cubit<MyProductsState> {
  MyProductsCubit() : super(MyProductsLoading());

  final ProductsRepository _productsRepository = ProductsRepository();

  Future<void> fetchData() async {
    emit(MyProductsLoading());
    try{
      List<Product> list = await _productsRepository.myProducts(id: MyUser.myUser!.id);
      emit(MyProductsSuccess(list: list));
    }catch(ex) {
      emit(MyProductsFailure(exception: ex as Exception));
    }
  }
}
