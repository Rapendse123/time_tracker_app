import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app/pages/sign_in_page.dart';
import 'package:time_tracker_app/services/auth.dart';

import 'home_page.dart';

class LandingPageScreen extends StatelessWidget {
  const LandingPageScreen({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          // '?' null aware operator prevents printing when user signs out
          print('User id: ${user?.uid}');
          if (user == null)
            return SignInPageScreen(
                auth: auth,
            );
          else
            return HomePageScreen(
              auth: auth,
            );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
