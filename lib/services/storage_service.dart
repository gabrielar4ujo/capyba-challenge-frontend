import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _instance = FirebaseStorage.instance;

  Future<String?> uploadFile(File? file, String fileName) async {
    if (file == null) {
      return null;
    }

    Reference ref = _instance.ref().child('usersPhoto').child('/$fileName.jpg');

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    UploadTask uploadTask = ref.putFile(File(file.path), metadata);
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }
}
