import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutLoading());
  final ProductsRepository _productsRepository = ProductsRepository();


  Future<void> fetchData() async {
    emit(HomeLayoutLoading());
    try{
      List<Product> list = await _productsRepository.index();
      emit(HomeLayoutSuccess(list: list));
    }catch(ex) {
      emit(HomeLayoutFailure(exception: ex as Exception));
    }
  }
}
