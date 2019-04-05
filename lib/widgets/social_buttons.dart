import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialButtons extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'dale',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w200),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 25.0,
                  ),
                ),
                Text(
                  'a Bookalo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w200),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    MdiIcons.facebook,
                    color: Colors.blue[900],
                    size: 30.0,
                  ),
                  onPressed: () {
                    _launchURL('http://facebook.com');
                  },
                ),
                Container(width: 5.0),
                IconButton(
                  icon: Icon(MdiIcons.twitter, color: Colors.blue, size: 30.0),
                  onPressed: () {
                    _launchURL('http://twitter.com');
                  },
                ),
                Container(width: 5.0),
                IconButton(
                  icon: Icon(MdiIcons.instagram,
                      color: Colors.purple, size: 30.0),
                  onPressed: () {
                    _launchURL('http://instagram.com/bookalo_es');
                  },
                )
              ],
            ),
            Container(height: 100.0),
          ],
        ),
      ),
    );
  }
}
