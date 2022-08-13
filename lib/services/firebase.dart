import 'package:firebase_auth/firebase_auth.dart';
import 'package:meribiltyapp/constants/main_constants.dart';

void checkCurrentUser() async {
  FirebaseAuth.instance.idTokenChanges().listen((User? user) async {
    
    if (user == null) {
      print('User is currently signed out!');
    } else {
      final tokenResult = await FirebaseAuth.instance.currentUser!;
      bool forceRefresh = true;
      final idToken = await tokenResult.getIdToken(forceRefresh);
      print('it is my token $idToken');
      box.write('token', idToken);

      print('User is signed in!');
      print('idToken === $idToken');
    }
  });
}
