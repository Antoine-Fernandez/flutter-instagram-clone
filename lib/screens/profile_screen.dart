import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/firestore_methods.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widget/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.uid});

  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<dynamic, dynamic> userData = <dynamic, dynamic>{};
  int postsLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final DocumentSnapshot<Map<String, dynamic>> userSnap =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(widget.uid)
              .get();
      // GET POST LENGTH
      final QuerySnapshot<Map<String, dynamic>> postSnap =
          await FirebaseFirestore.instance
              .collection('posts')
              .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get();

      postsLen = postSnap.docs.length;

      userData = userSnap.data()!;
      followers = userSnap.data()!["followers"].length;
      following = userSnap.data()!["following"].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      setState(() {
        userData = userData;
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userData['name']),
              centerTitle: false,
            ),
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              userData['photoUrl'],
                            ),
                            backgroundColor: Colors.grey,
                            radius: 40,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    buildStartColumn(postsLen, "posts"),
                                    buildStartColumn(followers, "followers"),
                                    buildStartColumn(following, "following"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    if (FirebaseAuth
                                            .instance.currentUser!.uid ==
                                        widget.uid)
                                      const FollowButton(
                                        text: 'Edit profil',
                                        backgroundColor: mobileBackgroundColor,
                                        textColor: primaryColor,
                                        borderColor: Colors.grey,
                                      )
                                    else
                                      isFollowing
                                          ? FollowButton(
                                              text: 'Unfollow',
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              borderColor: Colors.grey,
                                              function: () async {
                                                await FirestoreMethods()
                                                    .followUser(
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  userData['uid'],
                                                );
                                                setState(() {
                                                  isFollowing = false;
                                                  followers--;
                                                });
                                              },
                                            )
                                          : FollowButton(
                                              text: 'Follow',
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              borderColor: Colors.blue,
                                              function: () async {
                                                await FirestoreMethods()
                                                    .followUser(
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  userData['uid'],
                                                );
                                                setState(() {
                                                  isFollowing = true;
                                                  followers++;
                                                });
                                              },
                                            ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          userData['email'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          userData['bio'],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection("posts")
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final DocumentSnapshot<dynamic> snap =
                            (snapshot.data! as dynamic).docs[index];
                        return Image(
                          image: NetworkImage(
                            snap["postUrl"],
                          ),
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  },
                )
              ],
            ),
          );
  }

  Column buildStartColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
