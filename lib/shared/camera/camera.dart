import 'package:image_picker/image_picker.dart';

class Camera {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _image;

  Future<void> takePicture() async {
    XFile? _file = await _imagePicker.pickImage(
        imageQuality: 50, source: ImageSource.camera);
    _image = _file;
  }

  XFile? get image => _image;
}
