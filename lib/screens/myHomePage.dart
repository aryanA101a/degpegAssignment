import 'package:assignment/authentication/googleSignIn.dart';
import 'package:assignment/screens/gridPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      // appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/logo.png'),
            SizedBox(
              height: 50,
              child: SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(12)),
                onPressed: () {
                  authentication.signInWithGoogle(context).then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GridPage(),
                        ));
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
