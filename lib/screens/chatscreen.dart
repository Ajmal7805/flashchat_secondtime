// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_secondtime/const.dart';
import 'package:flutter/material.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  User? firebaseuser;
  String? messagetext;

  @override
  void initState() {
    super.initState();
    getcurrentuser();
  }

  void getcurrentuser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        firebaseuser = user;
        log(firebaseuser!.email.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // auth.signOut();
                // Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Getdatamodal> streamdatalists = [];
                  final messages = snapshot.data!.docs;
                  for (var getmessages in messages) {
                    final getmessahetext = getmessages.get('text');
                    final getemail = getmessages.get('email');
                    final streamdatalist = Getdatamodal(
                        getmessahetext: getmessahetext, getemail: getemail);
                    streamdatalists.add(streamdatalist);
                  }
                  return ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    children: streamdatalists,
                  );
                }
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      decoration: kMessageContainerDecoration,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                messagetext = value;
                              },
                              decoration: kMessageTextFieldDecoration,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              firestore.collection('messages').add({
                                'text': messagetext,
                                'email': firebaseuser!.email,
                              });
                            },
                            child: Text(
                              'Send',
                              style: kSendButtonTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
                return SizedBox();
              }),
        ),
      ),
    );
  }
}

class Getdatamodal extends StatelessWidget {
  const Getdatamodal({
    super.key,
    required this.getmessahetext,
    required this.getemail,
  });

  final String getmessahetext;
  final String getemail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            getemail,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(10),
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getmessahetext,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
