import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/notifications/save_token.dart';
import 'package:meribiltyapp/Api%20Services/wallet/wallet_controller_getx.dart';
import 'package:meribiltyapp/constants/main_constants.dart';

always_login() async {
  GetWalletController _walletController = Get.put(GetWalletController());
  try {
    UserCredential userloginStatus = await FirebaseAuth.instance
        .signInWithCustomToken(storage.getItem('apiToken'));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      // Get.to(SignIn());
    } else if (e.code == 'wrong-password') {
      //  Get.to(SignIn());
    }
  }

  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) {
    } else {
      print('User is signed in!');
      if (box.read('userType') == 'driver') {
        //  Get.to(DriverHome());
      } else if (box.read('userType') == 'vendor') {
        // Get.to(VenderHome());
      }
      // get idToken of user
      FirebaseAuth.instance.currentUser
          ?.getIdToken(true)
          .then((idToken) => {box.write('token', '$idToken')});
      print('${box.read('token')}');
      _walletController.fetchWallet();

      // Get the token each time the application loads

      String? fcm_token = await FirebaseMessaging.instance.getToken();

      // Save the initial token to the database
      await saveTokenToDatabase(fcm_token);

      // Any time the token refreshes, store this in the database too.
      FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
    }
  });
}
