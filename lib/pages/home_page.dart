import 'package:flutter/material.dart';
import 'package:time_tracker_app/services/auth.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key key, @required this.auth})
      : super(key: key);
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: _signOut,
          )
        ],
      ),
    );
  }
}
