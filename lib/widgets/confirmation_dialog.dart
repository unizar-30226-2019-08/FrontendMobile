import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';

enum ConfirmAction { CANCEL, ACCEPT }

Future<ConfirmAction> askConfirmation(BuildContext context, String titleKey, String acceptKey, String cancelKey, Widget body) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          Translations.of(context).text(titleKey),
          style: TextStyle(fontSize: 24),
        ),
        content: body,
        actions: <Widget>[(cancelKey.length > 0) ?
          FlatButton(
            child: Text(
              Translations.of(context).text(cancelKey),
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0),
            ),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          )
          : Container(),
          FlatButton(
            child: Text(
              Translations.of(context).text(acceptKey),
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0),
            ),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )          
          ],
        );
      },
    );
  }
