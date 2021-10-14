import 'package:image_picker/image_picker.dart';

class Camera {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _image;

  Future<void> takePicture() async {
    XFile? _file = await _imagePicker.pickImage(
        imageQuality: 30, source: ImageSource.camera);
    if (_file != null) {
      _image = _file;
    }
  }

  XFile? get image => _image;
}
