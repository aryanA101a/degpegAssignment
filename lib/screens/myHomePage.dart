import 'package:assignment/authentication/googleSignIn.dart';
import 'package:assignment/screens/gridPage.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                authentication.signInWithGoogle(context).then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GridPage(),
                      ));
                });
              },
              child: Text('Google Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
