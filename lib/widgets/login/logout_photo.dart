import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogoutPhoto extends StatelessWidget {

  final String url;

  LogoutPhoto({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(this.url),
          radius: 50.0,),
        GestureDetector(
          child: Icon(
            Icons.remove_circle,
            color: Colors.white,
            size: 35.0,
          ),
          onTap: () async{
            String provider = "";
            await FirebaseAuth.instance.currentUser().then((user){
              provider = user.providerData[1].providerId;
            });
            switch(provider){
              case "google.com":
                final GoogleSignIn g = new GoogleSignIn();
                g.disconnect();                
                break;
            }
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
        ),
      ],
    );
  }
}