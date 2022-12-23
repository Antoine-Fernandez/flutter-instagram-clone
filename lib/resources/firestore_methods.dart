import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Some error occured";

    try {
      final String photoUrl =
          await StorageMethods().uploadImageStorage("posts", file, true);
      final String postId = const Uuid().v1();

      final Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        likes: <dynamic>[],
      );
      await _firestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List<dynamic> likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore
            .collection("posts")
            .doc(postId)
            .update(<String, dynamic>{
          "likes": FieldValue.arrayRemove(<String>[uid]),
        });
      } else {
        await _firestore
            .collection("posts")
            .doc(postId)
            .update(<String, dynamic>{
          "likes": FieldValue.arrayUnion(<String>[uid]),
        });
      }
    } catch (e) {
      return;
    }
  }

  Future<String> postComment(
    String postId,
    String text,
    String uid,
    String name,
    String profilePic,
  ) async {
    try {
      if (text.isNotEmpty) {
        final String commmentId = const Uuid().v1();
        await _firestore
            .collection("posts")
            .doc(postId)
            .collection('comments')
            .doc(commmentId)
            .set(<String, dynamic>{
          "profilPic": profilePic,
          "name": name,
          "text": text,
          "commentId": commmentId,
          "datePublished": DateTime.now(),
        });
        return "success";
      } else {
        return "Text is empty";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      return;
    }
  }
}
