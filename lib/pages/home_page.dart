import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/widgets/show_alert_dialog.dart';

class HomePage extends StatelessWidget {

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure you want to Logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );
    if(didRequestSignOut == true){
      _signOut(context);
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
            onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
    );
  }
}
