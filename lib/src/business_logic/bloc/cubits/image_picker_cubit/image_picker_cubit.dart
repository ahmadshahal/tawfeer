import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerPending());

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage(ImageSource imageSource) async {
    final file = await _imagePicker.pickImage(source: imageSource);
    if(file == null) return;
    emit(ImagePickerSuccess(imagePath: file.path));
  }

}
