import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;

  Future<User> signInAnonymously();

  Future<User> signOut();

  Stream<User> authStateChanges();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  // it notifies changes to user's sign-in states, such as sign-in and sign-out
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    final userCredentials = await _firebaseAuth.signInAnonymously();
    // print('${userCredentials.user.uid}');
    return userCredentials.user;
  }

  @override
  Future<User> signOut() async {
    await _firebaseAuth.signOut();
  }
}
