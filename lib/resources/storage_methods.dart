import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageStorage(
    String childName,
    Uint8List file,
    bool isPost,
  ) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      final String id = const Uuid().v1();
      ref = ref.child(id);
    }

    final UploadTask uploadTask = ref.putData(file);
    final TaskSnapshot snap = await uploadTask;

    final String dlUrl = await snap.ref.getDownloadURL();
    return dlUrl;
  }
}
