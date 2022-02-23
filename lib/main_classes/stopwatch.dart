// import 'dart:async';
// // import 'dart:ffi';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stop_watch/main_classes/platform_alert.dart';

class StopWatch extends StatefulWidget{
  //constructor with name and email parameters
  final String? email;
  final String? name;
  StopWatch({this.name , this.email});

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
  // We will update the _stopTimer function so that it should accept build context
  void _stopTimer(BuildContext context){
    setState((){
      // miliseconds= 0;
      timer!.cancel();
      isStart = false;

    });
    // here we will write code for Alert Dialog
    // final initial_value= miliseconds;
    // var total_sec = laps.fold<int>(0, (total,lap) => total + lap);
    // final alert= PlatformAlert( // here we are declaring "alert" as a class's Object
    //     title: 'Finished',
    //     message: 'Laps Total : ${_secondsText(total_sec)} seconds.' ,
    // );
    // alert.show(context); // calling function from class's object

    //Here we will call for Bottom Sheet
    final controller =  showBottomSheet(context: context,
                        builder: _buildRunCompleteSheet);
    Future.delayed(Duration(seconds: 3)).then((_) => controller.close());
  }
  // now instead of showing Alert Dialog, we will show bottom sheet
  Widget _buildRunCompleteSheet(BuildContext context ){
    var totalRunTime= laps.fold<int>(miliseconds!, (total, lap) => total + lap);

    return Container(
      color: Color(0xff3eb489),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Run Finished 🎇 ", style: TextStyle(fontSize: 17)),
            SizedBox(height: 10,),
            Text("Total Runtime: ${_secondsText(totalRunTime)} " , style: TextStyle(fontSize: 15),)
          ],
        ),
      ),
    );
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
        // backgroundColor: Color(0xff3eb489),
        backgroundColor: Colors.white70,

      title: Text("${widget.name}", style: TextStyle(color: Color(0xff3eb489),)),

        actions: [
          Container(
              width: 100,
              height: 150,
              child: Image.asset('assets/web-logo.png'))
        ],
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
            Builder(
              builder: (context) => TextButton(
                  onPressed: isStart == true? () => _stopTimer(context): null,
                  child: Text('Stop'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30))
                  ),

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
          // cacheExtent: itemsHeight,
          itemExtent: itemsHeight,
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