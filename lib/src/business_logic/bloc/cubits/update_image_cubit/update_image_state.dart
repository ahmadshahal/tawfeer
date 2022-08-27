part of 'update_image_cubit.dart';

@immutable
abstract class UpdatedImageState {}

class UpdateImageInitial extends UpdatedImageState {}

class UpdateImageLoading extends UpdatedImageState {}

class UpdateImageSuccess extends UpdatedImageState {}

class UpdateImageFailure extends UpdatedImageState {
  final TawfeerException exception;
  UpdateImageFailure({required this.exception});
}
