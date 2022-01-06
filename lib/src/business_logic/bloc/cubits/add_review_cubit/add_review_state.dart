part of 'add_review_cubit.dart';

@immutable
abstract class AddReviewState {}

class AddReviewInitial extends AddReviewState {}

class AddReviewLoading extends AddReviewState {}

class AddReviewSuccess extends AddReviewState {}

class AddReviewFailure extends AddReviewState {
  final TawfeerException exception;

  AddReviewFailure({required this.exception});
}
