import 'package:bloc/bloc.dart';

class ImageProfileCubit extends Cubit<String> {
  ImageProfileCubit() : super('');

  void setImage(String imagePath) async {
    emit(imagePath);
  }
}
