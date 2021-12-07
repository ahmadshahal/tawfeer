import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';
import 'package:tawfeer/src/business_logic/models/product.dart';
import 'package:tawfeer/src/business_logic/utils/sorting_utility.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {

  final ProductsRepository _productsRepository = ProductsRepository();

  // 0 -> by price, 1 -> by views, 2 -> by date.
  int _sortIndex = 0;
  List<Product> _list = [];

  int get sortIndex {
    return _sortIndex;
  }

  HomeLayoutCubit() : super(HomeLayoutInitial());

  Future<void> fetchData() async {
    try {
      _list = await _productsRepository.index();
      _list = SortingUtility.sortBy(_list, _sortIndex);
      emit(HomeLayoutSuccess(list: _list));
    } catch (ex) {
      emit(HomeLayoutFailure(exception: ex as Exception));
    }
  }

  void updateSortIndex({required int sortIndex}) {
    _sortIndex = sortIndex;
    if (state is HomeLayoutSuccess) {
      _list = SortingUtility.sortBy(_list, _sortIndex);
      emit(HomeLayoutSuccess(list: _list));
    }
  }
}
