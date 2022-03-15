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
        title: const Text('Setting'),
      ),
      body: Center(
        child: InkWell(
            onTap: () {
              signOut().then((value) {
              
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: ((context) {
                  return SplashScreen();
                })), (route) => false);
              });

              
            },
            child: Text('logout')),
      ),
    );
  }
}
