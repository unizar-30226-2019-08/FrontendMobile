import 'package:flutter/material.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';

class LoginButton extends StatelessWidget {
  final bool inProgress;
  final IconData iconData;
  final Function callback;
  final Color color;

  LoginButton(
      {Key key, this.inProgress, this.iconData, this.callback, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
        child: Container(
          height: height / 9,
          color: color,
          child: Center(
            child: (!inProgress
                ? Icon(
                    iconData,
                    color: Colors.white,
                    size: 40.0,
                  )
                : BookaloProgressIndicator(color: Colors.white)
            )
          ),
        ),
        onTap: callback);
  }
}
