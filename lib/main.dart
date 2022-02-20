import 'package:flutter/material.dart';
import 'package:stop_watch/main_classes/stopwatch.dart';
import 'package:stop_watch/screens/login_screen.dart';

void main() => runApp(StopWatchApp());

class StopWatchApp extends StatelessWidget {
  const StopWatchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}
