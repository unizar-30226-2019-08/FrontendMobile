/*
 * FICHERO:     auth_utils.dart
 * DESCRIPCIÓN: utilidades para validación de usuario
 * CREACIÓN:    10/04/2019
 */ 

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> checkLogin() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try{
    final storage = new FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken");
    String idToken = await storage.read(key: "idToken");
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: accessToken,
      idToken: idToken,
    );    
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    return user != null;
  }catch(Exception){
    return false;
  }
}