import 'package:chat_app/page/chat_page.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/theme/my_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() {
    final authServices = Provider.of<AuthServices>(context, listen: false);

    authServices.signOut();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: Text(
          "Home page",
          style: TextStyle(color: MyColors.white),
        ),
        actions: [
          IconButton(
              onPressed: signOut,
              icon: const Icon(
                Icons.logout,
                color: MyColors.white,
              ))
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapsshot) {
          print(snapsshot.data!.docs);
          if (snapsshot.hasError) {
            return const Text("error");
          }
          if (snapsshot.connectionState == ConnectionState.waiting) {
            return const Text('loading..');
          }
          return ListView(
            children: snapsshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        leading: Icon(Icons.person),
        title: Text(data['email']),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverUserEmail: data['email'],
                        receiverUserID: data['uid'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
