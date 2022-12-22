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
  final List<String> followers;
  final List<String> following;
  final List<String> posts;
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
}
