import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  const User({
    required this.name,
    required this.email,
    required this.uid,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
    required this.posts,
    required this.isAdmin,
  });

  final String name;
  final String email;
  final String uid;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;
  final List posts;
  final bool isAdmin;

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "bio": bio,
        "photoUrl": photoUrl,
        "followers": followers,
        "following": following,
        "posts": posts,
        "isAdmin": isAdmin,
      };

  static User fromSnap(DocumentSnapshot snap) {
    final Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;

    return User(
      name: snapshot['name'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      posts: snapshot['posts'],
      isAdmin: snapshot['isAdmin'],
    );
  }
}
