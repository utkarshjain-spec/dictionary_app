import 'package:dictionary_app/screens/login_page.dart';
import 'package:dictionary_app/screens/spash_screen.dart';
import 'package:dictionary_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({Key? key}) : super(key: key);

  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  bool isUserLoggedIn = false;
  String? currentUserName;
  Future<bool?> checkUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = await auth.currentUser;
    if (user != null) {
      currentUserName = user.displayName.toString();
      isUserLoggedIn = true;
      setState(() {});
    } else {
      isUserLoggedIn = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    checkUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 85, 134),
        title: const Text('Setting'),
        actions: [
          IconButton(
              onPressed: () {
                Share.share(
                  "https://github.com/X-Wei/flutter_catalog/blob/master/lib/routes/appbar_search_ex.dart",
                );
              },
              icon: Icon(Icons.share)),
        ],
      ),
      body: Center(
          child: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
              (Set<MaterialState> states) {
                return EdgeInsets.symmetric(horizontal: 25, vertical: 15);
              },
            ),
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 25, 85, 134))),

        // style: Button,
        onPressed: () {
          if (isUserLoggedIn) {
            signOut().then((value) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: ((context) {
                return SplashScreen();
              })), (route) => false);
            });
          } else {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: ((context) {
              return LoginPage();
            })), (route) => false);
          }
        },
        child: Text(
          isUserLoggedIn ? 'Sign Out' : 'Sign In',
          style: TextStyle(color: Colors.white),
        ),
      )),
    );
  }
}
