import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/business_logic/utils/sorting_utility.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());
  final ProductsRepository _productsRepository = ProductsRepository();
  int sortIndex = 0;

  Future<void> fetchData() async {
    try{
      List<Product> list = await _productsRepository.index();
      if(sortIndex == 0) {
        list = SortingUtility.sortByPrice(list);
      }
      else if(sortIndex == 1) {
        list = SortingUtility.sortByViews(list);
      }
      // TODO: sort by date.
      emit(HomeLayoutSuccess(list: list));
    }catch(ex) {
      emit(HomeLayoutFailure(exception: ex as Exception));
    }
  }
}
