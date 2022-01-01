import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerPending());

  final ImagePicker _imagePicker = ImagePicker();
  XFile? file;

  Future<void> pickImage(ImageSource imageSource) async {
    final XFile? xFile = await _imagePicker.pickImage(source: imageSource);
    if(xFile == null) return;
    file = xFile;
    if(isClosed) return;
    emit(ImagePickerSuccess(imagePath: file!.path));
  }
}
