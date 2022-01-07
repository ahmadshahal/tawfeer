part of 'like_review_cubit.dart';

@immutable
abstract class LikeReviewState {}

class LikeReviewInitial extends LikeReviewState {}

class LikeReviewLoading extends LikeReviewState {}

class LikeReviewSuccess extends LikeReviewState {}

class LikeReviewFailure extends LikeReviewState {
  final TawfeerException exception;

  LikeReviewFailure({required this.exception});
}
