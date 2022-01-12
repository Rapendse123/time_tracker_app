import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/home/jobs/edit_job_page.dart';
import 'package:time_tracker_app/home/jobs/list_items_builder.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/services/database.dart';
import 'package:time_tracker_app/widgets/exception_alert_dialog.dart';
import 'package:time_tracker_app/widgets/job_list_tile.dart';
import 'package:time_tracker_app/widgets/show_alert_dialog.dart';
import '../models/job.dart';

class JobsPage extends StatelessWidget {
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
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
            snapshot: snapshot,
            itemBuilder: (context, job) => Dismissible(
                  key: Key('job-${job.id}'),
                  background: Container(
                    color: Colors.red,
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) => _delete(context, job),
                  child: JobListTile(
                    job: job,
                    onTap: () => EditJobPage.show(context, job: job),
                  ),
                ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Jobs')),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => EditJobPage.show(context),
      ),
      body: _buildContents(context),
    );
  }
}
