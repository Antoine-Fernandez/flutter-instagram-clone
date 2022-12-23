import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/feed_screen.dart';

const int web = 600;

const List<Widget> screens = <Widget>[
  FeedScreen(),
  Center(child: Text("search")),
  AddPostScreen(),
  Center(child: Text("favorite")),
  Center(child: Text("person")),
];
