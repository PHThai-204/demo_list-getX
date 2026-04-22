import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> uploadImage({required File file}) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final path = 'products/$fileName.jpg';

      final ref = _storage.ref().child(path);

      final snapshot = await ref.putFile(file);

      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Upload failed: $e');
    }
  }
}
