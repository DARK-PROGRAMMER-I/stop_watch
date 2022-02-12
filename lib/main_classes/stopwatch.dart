import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget{
  @override
  State createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch>{
  // Now we need to create Seconds and timer
  int? seconds;
  Timer? timer;

  // now build functions
  @override
  void initState(){
    super.initState();

    seconds= 0;
    timer= Timer.periodic(Duration(seconds:1), _onTick);
  }
  // Function for incrementing the number
  void _onTick(Timer time){
    setState(() {
      seconds= seconds!+ 1 ;
    });
  }

  // Creating dynamic text -> use infront of seconds
  String _secondsText() => seconds == 1? 'second': 'seconds';
  // create a function to stop Timer when off the screen
  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3eb489),
        title: Text("Stop Watch", style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        child: Center(
          child: Text("$seconds ${_secondsText()}", style: TextStyle(fontSize: 20),),
        ),
      ),
    );
  }
}