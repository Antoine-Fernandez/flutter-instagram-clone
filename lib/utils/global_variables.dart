import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/feed_screen.dart';
import 'package:instagram/screens/search_screen.dart';

const int web = 600;

const List<Widget> screens = <Widget>[
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Center(child: Text("favorite")),
  Center(child: Text("person")),
];
