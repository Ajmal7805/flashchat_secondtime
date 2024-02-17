// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_secondtime/const.dart';
import 'package:flashchat_secondtime/screens/chatscreen.dart';
import 'package:flashchat_secondtime/screens/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  String? email;
  String? password;
  bool spinner = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              const SizedBox(
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
              const SizedBox(
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
              const SizedBox(
                height: 24.0,
              ),
              materialbuttonmodal(
                  textcolor: Colors.white,
                  loginorsighup: "Log in",
                  navigatorfunction: () async {
                    setState(() {
                      spinner = true;
                    });
                    try {
                      final olduser = await auth.signInWithEmailAndPassword(
                          email: email.toString(),
                          password: password.toString());
                      if (olduser != null) {
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
                    } on Exception catch (e) {
                      log(e.toString());
                    }
                  },
                  colors: Colors.lightBlueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
