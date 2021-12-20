part of 'image_picker_cubit.dart';

@immutable
abstract class ImagePickerState {}

class ImagePickerPending extends ImagePickerState {}

class ImagePickerSuccess extends ImagePickerState {
  final String imagePath;
  ImagePickerSuccess({required this.imagePath});
}
