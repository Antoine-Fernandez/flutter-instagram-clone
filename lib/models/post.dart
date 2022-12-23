import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  const Post({
    required this.username,
    required this.description,
    required this.uid,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  final String username;
  final String description;
  final String uid;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final List<dynamic> likes;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "username": username,
        "description": description,
        "uid": uid,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profImage": profImage,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot<Object?> snap) {
    final Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      description: snapshot['description'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
    );
  }
}
