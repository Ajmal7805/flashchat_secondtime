// ignore_for_file: prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashchat_secondtime/screens/loginscreen.dart';
import 'package:flashchat_secondtime/screens/sighupscreen.dart';
import 'package:flutter/material.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({Key? key}) : super(key: key);

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    controller.addListener(() {
      setState(() {
        animation!.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                      height: 60.0, child: Image.asset('images/logo.png')),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  pause: const Duration(milliseconds: 100),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            materialbuttonmodal(
              textcolor: Colors.white,
              colors: Colors.lightBlueAccent,
              loginorsighup: 'Log In',
              navigatorfunction: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Loginscreen();
                  },
                ));
              },
            ),
            materialbuttonmodal(
              textcolor: Colors.white,
              colors: Colors.blueAccent,
              loginorsighup: 'Register',
              navigatorfunction: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Sighupscreen();
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}

class materialbuttonmodal extends StatelessWidget {
  final String loginorsighup;
  final Function navigatorfunction;
  final Color colors;
  final Color? textcolor;

  const materialbuttonmodal({
    Key? key,
    required this.loginorsighup,
    required this.navigatorfunction,
    required this.colors,
    this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colors,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () => navigatorfunction(),
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            loginorsighup,
            style: TextStyle(color: textcolor),
          ),
        ),
      ),
    );
  }
}
