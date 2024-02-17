import 'package:firebase_core/firebase_core.dart';
import 'package:flashchat_secondtime/firebase_options.dart';
import 'package:flashchat_secondtime/screens/welcomescreen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    title: 'Flashchat',
    home: Welcomescreen(),
  ));
}
