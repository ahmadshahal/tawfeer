part of 'like_review_delete_cubit.dart';

@immutable
abstract class LikeReviewDeleteState {}

class LikeReviewDeleteInitial extends LikeReviewDeleteState {}

class LikeReviewDeleteLoading extends LikeReviewDeleteState {}

class LikeReviewSuccess extends LikeReviewDeleteState {}

class DeleteProductSuccess extends LikeReviewDeleteState {}

class LikeReviewDeleteFailure extends LikeReviewDeleteState {
  final TawfeerException exception;

  LikeReviewDeleteFailure({required this.exception});
}
