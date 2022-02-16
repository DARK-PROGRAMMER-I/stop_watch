import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget{
  @override
  State createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch>{
  // Now we need to create Seconds and timer
  bool? isStart = false;
  int? seconds= 0;
  Timer? timer;

  // now build functions
  // Building functions for stoping and Starting the timer
  void _startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), _onTick);

    setState(() {
      seconds= 0;
      isStart= true;
    });
  }
  // Stop Timer
  void _stopTimer(){
    setState((){
      timer!.cancel();
      isStart = false;

    });
  }
  // Function for incrementing the number
  void _onTick(Timer time){
    setState(() {
      seconds= seconds!+ 1 ;
    });
  }

  // Creating dynamic text -> use infront of seconds
  String _secondsText() => seconds == 1? 'second': 'seconds';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3eb489),
        title: Text("Stop Watch", style: TextStyle(color: Colors.white),),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Center(
            child: Text("$seconds ${_secondsText()}", style: TextStyle(fontSize: 20),),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: _startTimer,
                  child: Text("Start", style: TextStyle(fontSize: 16, letterSpacing: 2),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff3eb489)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30))
                  ),

              ),
              SizedBox(width: 20,),
              TextButton(
                  onPressed: _stopTimer,
                  child: Text('Stop'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.red),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30))
                  ),

              )

            ],
          )
      ]
      ),

    );
  }
}