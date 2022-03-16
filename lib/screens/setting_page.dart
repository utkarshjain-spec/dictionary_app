import 'package:dictionary_app/screens/spash_screen.dart';
import 'package:dictionary_app/services/auth.dart';
import 'package:flutter/material.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({Key? key}) : super(key: key);

  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 85, 134),
        title: const Text('Setting'),
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
          signOut().then((value) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: ((context) {
              return SplashScreen();
            })), (route) => false);
          });
        },
        child: Text(
          "Logout",
          style: TextStyle(color: Colors.white),
        ),
      )),
    );
  }
}
