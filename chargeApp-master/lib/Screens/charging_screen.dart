import 'dart:async';

import 'package:charging_app/Screens/Charging_summary_screen.dart';
import 'package:charging_app/Screens/charge_duration.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Charging_screen extends StatefulWidget {
  int duration;
  Charging_screen({Key? key, required this.duration}) : super(key: key);

  @override
  _Charging_screenState createState() => _Charging_screenState();
}

class _Charging_screenState extends State<Charging_screen> {
  CountDownController _controller = CountDownController();
  Timer? countdownTimer;
  Duration myDuration = Duration();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _duration = widget.duration;
    myDuration = Duration(minutes: widget.duration);
    startTimer();
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer?.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  String mins = "";
  String sec = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              Center(
                child: Container(
                  padding: EdgeInsets.all(12),
                  // margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.greenAccent, Colors.green.shade50]),
                  ),
                  child: Text(
                    "Congratulations, you've burnt 150 carbon",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  children: [
                    Center(
                      child: CircularCountDownTimer(
                        duration: widget.duration * 60,
                        controller: _controller,
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 2,
                        ringColor: Colors.grey[300]!,
                        ringGradient:
                            LinearGradient(colors: [Colors.black, Colors.grey]),
                        fillColor: Colors.blue,
                        fillGradient: LinearGradient(colors: [
                          Colors.blue.shade300,
                          Colors.blue.shade900
                        ]),
                        backgroundColor: Colors.grey[500],
                        backgroundGradient: LinearGradient(colors: [
                          Colors.grey.shade900,
                          Colors.grey.shade500
                        ]),
                        strokeWidth: 20.0,
                        strokeCap: StrokeCap.round,
                        textStyle: TextStyle(
                            fontSize: 33.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        // textFormat: CountdownTextFormat.MM_SS,
                        isTimerTextShown: true,
                        isReverse: false,
                        onComplete: () {
                          debugPrint('Countdown Ended');
                          Route route = MaterialPageRoute(
                              builder: (_) => Charging_summary(
                                  duration: widget.duration,
                                  mins: mins,
                                  sec: sec));
                          Navigator.push(context, route);
                        },
                      ),
                    ),
                    //   SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flash_on,
                          size: 30,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Charging",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    //SizedBox(height: 5,),

                    BuildTime(),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueGrey, //New
                        blurRadius: 7.0,
                        offset: Offset(0, 0))
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.all(15),
                  // height: 130,
                  // width:MediaQuery.of(context).size.width ,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Powerstrip O51 AQ",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "PS 190087HJIM78",
                                style:
                                    TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                            ],
                          ),
                          Text(
                            "₹28.87",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary: Colors.red.shade900,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                // minimumSize: Size(50,20 ),
                              ),
                              child: Text(
                                "Tap to Stop ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget BuildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(myDuration.inHours.remainder(24));
    final minutes = twoDigits(myDuration.inMinutes.remainder(60));
    final seconds = twoDigits(myDuration.inSeconds.remainder(60));
    mins = minutes;
    sec = seconds;
    return Text(
      "$hours:$minutes:$seconds  Time Remaining",
      style: TextStyle(fontSize: 14, color: Colors.white),
    );
  }
}
