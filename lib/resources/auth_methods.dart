import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:instagram/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || bio.isNotEmpty) {
        // ------------------ CREATE USER IN FIREBASE AUTH ------------------

        final UserCredential createdUser = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        final String photoUrl = await StorageMethods()
            .uploadImageStorage('profilePics', file, false);

        // ------------------ CREATE COLLECTION ------------------

        final model.User user = model.User(
          name: username,
          email: email,
          uid: createdUser.user!.uid,
          bio: bio,
          posts: [],
          followers: [],
          following: [],
          photoUrl: photoUrl,
          isAdmin: false,
        );

        await _firestore.collection("users").doc(createdUser.user!.uid).set(
              user.toJson(),
            );
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
