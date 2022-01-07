import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';
import 'package:tawfeer/src/business_logic/utils/exceptions.dart';

part 'add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  AddReviewCubit() : super(AddReviewInitial());

  final ProductsRepository _productsRepository = ProductsRepository();

  Future<void> addReview({required String comment, required int id}) async {
    emit(AddReviewLoading());
    try {
      await _productsRepository.addReview(comment: comment, id: id);
      if (isClosed) return;
      emit(AddReviewSuccess());
    } on TawfeerException catch (ex) {
      if (isClosed) return;
      emit(AddReviewFailure(exception: ex));
    }
  }
}
