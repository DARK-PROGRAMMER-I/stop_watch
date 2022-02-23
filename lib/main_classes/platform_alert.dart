// import 'dart:html';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class PlatformAlert{
  final String title;
  final String message;

  const PlatformAlert({required this.title, required this.message});
  // Construnting a function so that we could show dialouge box
  void show(BuildContext context){
    final platform= Theme.of(context).platform;
    if(platform == TargetPlatform.iOS){
      _buildCupertinoAlert(context);
    }else{
      _buildMaterialAlert(context);
    }
}

  _buildMaterialAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('close'),
              )
            ],
          );
        }
    );
  }

  _buildCupertinoAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context){
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              CupertinoButton(
                  child: Text("close"),
                  onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        },
    );
  }

}


