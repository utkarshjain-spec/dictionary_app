import 'dart:async';
import 'package:dictionary_app/constants.dart';
import 'package:dictionary_app/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../local_data_saver.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2000), () {
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
      checkUserLog();
    });
  }

  void checkUserLog() async {
    Constants.name = (await LocalDataSaver.getName()) ?? '';
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = await auth.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
          context, (MaterialPageRoute(builder: (_) => HomePage())));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // return authState();
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Text(
            "Dictionary App",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
