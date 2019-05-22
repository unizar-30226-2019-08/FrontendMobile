/*
 * FICHERO:     auth_utils.dart
 * DESCRIPCIÓN: funciones relativas a la autenticación de usuarios
 * CREACIÓN:    20/04/2019
 */
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bookalo/utils/http_utils.dart';

enum LoginResult {
  first_time,
  completed,
  banned,
  backend_errored,
  firebase_errored,
  unknown_errored,
}

/*
 * Pre:   ---
 * Post:  ha completado el proceso de login y devuelto la posición actual
 *        del usuario
 */
Future<LoginResult> completeLogin() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  Position position = await Geolocator()
      .getLastKnownPosition(desiredAccuracy: LocationAccuracy.medium);
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.requestNotificationPermissions();
  var response = await http.post('https://bookalo.es/api/login', headers: {
    'appmovil': 'true'
  }, body: {
    'token': await user.getIdToken(),
    'fcm_token': await _firebaseMessaging.getToken(),
    'latitud': position.latitude.toString(),
    'longitud': position.longitude.toString()
  });
  switch (response.statusCode) {
    case 200:
      return LoginResult.completed;
    case 201:
      return LoginResult.first_time;
    case 400:
      return LoginResult.backend_errored;
    case 401:
      return LoginResult.banned;
    case 404:
      return LoginResult.firebase_errored;
    default:
      return LoginResult.unknown_errored;
  }
}

/*
  * Pre:   ---
  * Post:  ha lanzado el proceso de inicio de sesión con Google
  */
Future<AuthCredential> signInWithGoogle() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  return GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
}

/*
 * Pre:   ---
 * Post:  ha lanzado el proceso de inicio de sesión con Twitter
 */
Future<AuthCredential> signInWithTwitter() async {
  var twitterLogin = TwitterLogin(
    consumerKey: '7GfNxhqmPRol06FtTbprVA0Nk',
    consumerSecret: 'cDVemq5RmvHxt1oqhX2Qg0fPTrYDPjjziwZxbbtBTiSnQw5ne8',
  );
  final TwitterLoginResult result = await twitterLogin.authorize();
  return TwitterAuthProvider.getCredential(
      authToken: result.session.token, authTokenSecret: result.session.secret);
}

/*
 * Pre:   ---
 * Post:  ha lanzado el proceso de inicio de sesión con Facebook
 */
Future<AuthCredential> signInWithFacebook() async {
  final facebookLogin = FacebookLogin();
  final result = await facebookLogin.logInWithReadPermissions(['email']);
  return FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token);
}

/*
 * Pre:   ---
 * Post:  ha completado el inicio de sesión en Firebase con el proveedor indicado
 */
Future<void> signInFirebase(String provider) async {
  AuthCredential credential;
  switch (provider) {
    case "Google":
      credential = await signInWithGoogle();
      break;
    case "Twitter":
      credential = await signInWithTwitter();
      break;
    case "Facebook":
      credential = await signInWithFacebook();
      break;
  }
  await FirebaseAuth.instance.signInWithCredential(credential);
}

/*
 * Pre:   ---
 * Post:  ha cerrado la sesión tanto en Firebase como en el proveedor
 */
Future<void> signOut() async {
  String provider = "";
  await logout();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  await _firebaseMessaging.deleteInstanceID();
  await FirebaseAuth.instance.currentUser().then((user) {
    provider = user.providerData[1].providerId;
  });

  try {
    switch (provider) {
      case "google.com":
        final GoogleSignIn g = GoogleSignIn();
        await g.disconnect();
        break;
      case "twitter.com":
        var twitterLogin = TwitterLogin(
          consumerKey: '7GfNxhqmPRol06FtTbprVA0Nk',
          consumerSecret: 'cDVemq5RmvHxt1oqhX2Qg0fPTrYDPjjziwZxbbtBTiSnQw5ne8',
        );
        await twitterLogin.logOut();
        break;
      case "facebook.com":
        final facebookLogin = FacebookLogin();
        await facebookLogin.logOut();
        break;
    }
  } catch (e) {}
  FirebaseAuth.instance.signOut();
}
