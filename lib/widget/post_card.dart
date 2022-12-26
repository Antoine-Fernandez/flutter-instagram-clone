import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/resources/firestore_methods.dart';
import 'package:instagram/screens/comments_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/global_variables.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widget/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.snap});

  final dynamic snap;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      final QuerySnapshot<dynamic> snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection("comments")
          .get();

      commentLen = snap.docs.length;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: width > web ? secondaryColor : mobileBackgroundColor),
        ),
        child: Column(
          children: <Widget>[
            // ------------- HEAD SECTION -------------
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      widget.snap['profImage'],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.snap['username'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: <String>[
                              'Delete',
                            ]
                                .map(
                                  (String e) => InkWell(
                                    onTap: () async {
                                      await FirestoreMethods().deletePost(
                                        widget.snap['postId'],
                                      );
                                      if (!mounted) return;
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      child: Text(e),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.more_vert),
                  )
                ],
              ),
            ),
            // ------------- IMG SECTION -------------
            GestureDetector(
              onDoubleTap: () async {
                await FirestoreMethods().likePost(
                  widget.snap['postId'],
                  user.uid,
                  widget.snap["likes"],
                );
                setState(() {
                  isLikeAnimating = true;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: Image.network(
                      widget.snap['postUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isLikeAnimating ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: isLikeAnimating,
                      duration: const Duration(milliseconds: 400),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 120,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // ------------- ACTIONS SECTION -------------
            Row(
              children: <Widget>[
                LikeAnimation(
                  isAnimating: widget.snap['likes'].contains(user.uid),
                  smallLike: true,
                  child: IconButton(
                    onPressed: () async {
                      await FirestoreMethods().likePost(
                        widget.snap['postId'],
                        user.uid,
                        widget.snap["likes"],
                      );
                      setState(() {
                        isLikeAnimating = true;
                      });
                    },
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border,
                          ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => CommentScreen(
                        snap: widget.snap,
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.comment_outlined,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
            // ------------- DESCRIPTION SECTION -------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      '${widget.snap['likes'].length} likes',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: primaryColor),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.snap["username"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' ${widget.snap['description']}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "View all $commentLen commments",
                        style: const TextStyle(
                            fontSize: 16, color: secondaryColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMM()
                          .format(widget.snap["datePublished"].toDate()),
                      style:
                          const TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      //
    );
  }
}
