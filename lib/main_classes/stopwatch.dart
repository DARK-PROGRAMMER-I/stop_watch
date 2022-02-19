import 'dart:async';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StopWatch extends StatefulWidget{
  @override
  State createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch>{
  // Now we need to create Seconds and timer
  bool? isStart = false;
  int? miliseconds= 0;
  Timer? timer;
  // Adding Laps
  final laps = <int>[];
  // controlling list items
  final itemsHeight= 60.0;
  final scrollController= ScrollController();
  // Creating function for laps
  void _lap(){
    setState(() {
      laps.add(miliseconds!);
      miliseconds = 0;
    });

    // now we need to show animation when a new list item appears the list show scroll up.
    scrollController.animateTo(
        itemsHeight* laps.length,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn);
  }
  // now build functions
  // Function for incrementing the number
  void _onTick(Timer time){
    setState(() {
      miliseconds= miliseconds!+ 100 ;
    });
  }
  // Building functions for stoping and Starting the timer
  void _startTimer(){
    timer = Timer.periodic(Duration(milliseconds: 100), _onTick);

    setState(() {
      miliseconds= 0;
      isStart= true;
      laps.clear();
    });
  }

  // Stop Timer
  void _stopTimer(){
    setState((){
      // miliseconds= 0;
      timer!.cancel();
      isStart = false;

    });
  }


  // Creating dynamic text -> use infront of seconds
  String _secondsText(int miliseconds){
    final seconds= miliseconds/1000;
    return "$seconds seconds";
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3eb489),
        title: Text("Stop Watch", style: TextStyle(color: Colors.white),),
      ),
      body:  Column(
        children: [
          Expanded(child: _buildCounter()),
          Expanded(child: _buildLapDiusplay())
        ],
      ),

    );
  }

  Widget _buildCounter() {
    return Container(
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text("Laps ${laps.length + 1}", style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Color(0xff3eb489))),
          SizedBox(height: 18,),
          Center(
            child: Text(" ${_secondsText(miliseconds!)}", style: TextStyle(fontSize: 20),),
          ),
          SizedBox(height: 15,),
          _buildControls()
      ]
      ),
    );
  }

  Widget _buildControls() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: isStart == false? _startTimer: null,
                child: Text("Start", style: TextStyle(fontSize: 16, letterSpacing: 2),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff3eb489)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30))
                ),

            ),
            SizedBox(width: 20,),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                  foregroundColor: MaterialStateProperty.all(Colors.white, ),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30))
                ),
                onPressed: isStart! ? _lap : null ,
                child: Text("Lap", style: TextStyle(fontSize: 16),)
            ),
            SizedBox(width: 20,),
            TextButton(
                onPressed: isStart == true? _stopTimer: null,
                child: Text('Stop'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30))
                ),

            )

          ],
        );
  }

  Widget _buildLapDiusplay(){
    return Scrollbar(
      showTrackOnHover: true,
      child: ListView.builder(
          controller: scrollController,
          cacheExtent: itemsHeight,
          itemCount: laps.length,
          itemBuilder: (context, index){
            final  miliseconds= laps[index];
            return ListTile(
              title: Text("Lap ${index + 1}"),
              trailing: Text("${_secondsText(miliseconds)}"),

            );
          }

      ),
    );
  }
}