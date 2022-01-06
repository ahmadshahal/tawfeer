import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tawfeer/src/business_logic/bloc/repositories/user_repository.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/business_logic/utils/exceptions.dart';

part 'update_image_state.dart';

class UpdateImageCubit extends Cubit<UpdatedImageState> {
  UpdateImageCubit() : super(UpdateImageInitial());

  final ImagePicker _imagePicker = ImagePicker();
  final UserRepository _userRepository = UserRepository();

  Future<void> pickImage(ImageSource imageSource) async {
    final XFile? xFile = await _imagePicker.pickImage(source: imageSource);
    if(xFile == null) return;
    if(isClosed) return;
    emit(UpdateImageLoading());
    try {
      await _userRepository.updateImg(File(xFile.path));
      Shared.myUser = await _userRepository.profile();
      if(isClosed) return;
      emit(UpdateImageSuccess());
    } on TawfeerException catch(ex) {
      if(isClosed) return;
      emit(UpdateImageFailure(exception: ex));
    }
  }
}
