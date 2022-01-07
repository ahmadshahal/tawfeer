import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/products_repository.dart';
import 'package:tawfeer/src/business_logic/utils/exceptions.dart';

part 'like_review_delete_state.dart';

class LikeReviewDeleteCubit extends Cubit<LikeReviewDeleteState> {
  LikeReviewDeleteCubit() : super(LikeReviewDeleteInitial());

  final ProductsRepository _productsRepository = ProductsRepository();

  Future<void> deleteProduct({required int id}) async {
    emit(LikeReviewDeleteLoading());
    try {
      await _productsRepository.deleteProduct(id: id);
      if (isClosed) return;
      emit(DeleteProductSuccess());
    } on TawfeerException catch (ex) {
      if (isClosed) return;
      emit(LikeReviewDeleteFailure(exception: ex));
    }
  }

  Future<void> addReview({required String comment, required int id}) async {
    emit(LikeReviewDeleteLoading());
    try {
      await _productsRepository.addReview(comment: comment, id: id);
      if (isClosed) return;
      emit(LikeReviewSuccess());
    } on TawfeerException catch (ex) {
      if (isClosed) return;
      emit(LikeReviewDeleteFailure(exception: ex));
    }
  }

  Future<void> addLike({required int id}) async {
    emit(LikeReviewDeleteLoading());
    try {
      await _productsRepository.addLike(id: id);
      if (isClosed) return;
      emit(LikeReviewSuccess());
    } on TawfeerException catch (ex) {
      if (isClosed) return;
      emit(LikeReviewDeleteFailure(exception: ex));
    }
  }

  Future<void> removeLike({required int id}) async {
    emit(LikeReviewDeleteLoading());
    try {
      await _productsRepository.removeLike(id: id);
      if (isClosed) return;
      emit(LikeReviewSuccess());
    } on TawfeerException catch (ex) {
      if (isClosed) return;
      emit(LikeReviewDeleteFailure(exception: ex));
    }
  }

}
