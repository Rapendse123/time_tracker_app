import 'package:flutter/material.dart';
import 'package:time_tracker_app/pages/email_sign_in_form_page.dart';
import 'package:time_tracker_app/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  final AuthBase auth;

  EmailSignInPage({@required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: EmailSignInForm(
              auth: auth,
            )),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
