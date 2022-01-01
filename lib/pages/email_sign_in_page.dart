import 'package:flutter/material.dart';
import 'package:time_tracker_app/pages/email_sign_in_form_page.dart';

class EmailSignInPage extends StatelessWidget {
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
          child: EmailSignInFormPage(),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
