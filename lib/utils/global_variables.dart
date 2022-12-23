import 'package:flutter/material.dart';
import 'package:instagram/screens/home_screen.dart';
import 'package:instagram/screens/add_post_screen.dart';

const int web = 600;

const screens = [
  Center(child: Text("feed")),
  Center(child: Text("search")),
  Center(child: AddPostScreen()),
  Center(child: Text("favorite")),
  Center(child: Text("person")),
];
