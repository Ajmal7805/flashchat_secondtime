// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_secondtime/const.dart';
import 'package:flashchat_secondtime/screens/chatscreen.dart';
import 'package:flashchat_secondtime/screens/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Sighupscreen extends StatefulWidget {
  const Sighupscreen({super.key});

  @override
  State<Sighupscreen> createState() => _SighupscreenState();
}

class _SighupscreenState extends State<Sighupscreen> {
  String? email;
  String? password;
  bool spinner = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 150.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: textfielddecoration.copyWith(
                      hintText: 'Enter Your Username')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: textfielddecoration.copyWith(
                      hintText: 'Enter Your Password')),
              SizedBox(
                height: 24.0,
              ),
              materialbuttonmodal(
                  textcolor: Colors.white,
                  loginorsighup: "Register",
                  navigatorfunction: () async {
                    setState(() {
                      spinner = true;
                    });
                    try {
                      final newuser = await auth.createUserWithEmailAndPassword(
                          email: email.toString(),
                          password: password.toString());
                      if (newuser != null) {
                        if (mounted) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Chatscreen();
                            },
                          ));
                        }
                      }
                      setState(() {
                        spinner = false;
                      });
                    } catch (e) {
                      log(e.toString());
                    }
                  },
                  colors: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
