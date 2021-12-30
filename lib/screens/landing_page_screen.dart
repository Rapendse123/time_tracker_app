import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app/screens/home_page_screen.dart';
import 'package:time_tracker_app/screens/sign_in_page_screen.dart';
import 'package:time_tracker_app/services/auth.dart';

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _LandingPageScreenState createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  User _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateUser(widget.auth.currentUser);
    // '?' null aware operator prevents printing when user signs out
    // widget.auth.authStateChanges().listen((user) {
    //   print('User id: ${user?.uid}');
    // });
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
    // print('User id: ${user.uid}');
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null)
      return SignInPageScreen(
          auth: widget.auth, onSignIn: (user) => _updateUser(user));
    else
      return HomePageScreen(
        auth: widget.auth,
        onSignOut: () => _updateUser(null),
      );
  }
}
