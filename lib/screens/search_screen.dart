import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: "Search for a user",
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    "name",
                    isGreaterThanOrEqualTo: searchController.text,
                  )
                  .get(),
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
              ) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          (snapshot.data! as dynamic).docs[index]['photoUrl'],
                        ),
                      ),
                      title: Text(
                        (snapshot.data! as dynamic).docs[index]['name'],
                      ),
                    );
                  },
                  itemCount: (snapshot.data! as dynamic).docs.length,
                );
              },
            )
          : FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
              ) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return MasonryGridView.count(
                  crossAxisCount: 3,
                  itemBuilder: (BuildContext context, int index) =>
                      Image.network(
                    (snapshot.data as dynamic).docs[index]['postUrl'],
                  ),
                  itemCount: (snapshot.data as dynamic).docs.length,
                );
              },
            ),
    );
  }
}
