import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffeeapp/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Profile _userFromFirebaseUser(User? user) {
    return Profile(uid: user!.uid);
  }

  Stream<Profile> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email

  //register email

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
