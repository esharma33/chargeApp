import 'package:charging_app/Screens/charging_screen.dart';
import 'package:charging_app/Screens/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Charge_duration_screen extends StatefulWidget {
  const Charge_duration_screen({Key? key}) : super(key: key);

  @override
  _Charge_duration_screenState createState() => _Charge_duration_screenState();
}

class _Charge_duration_screenState extends State<Charge_duration_screen> {
  int _count = 0;
  int? _value = 1;
  void _increaseCount() {
    setState(() {
      _count++;
    });
  }

  void _decreaseCount() {
    if (_count <= 0) return;
    setState(() {
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/parking.jpg"),
                        radius: 25,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Powerstrip O51 AQ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "PS 190087HJIM78",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Set duration",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onSurface: Colors.blue,
                      //primary: Colors.grey,
                      padding: EdgeInsets.all(10),
                      minimumSize: Size(65, 50),
                    ),
                    onPressed: _decreaseCount,
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 16,
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 51,
                  width: 221,
                  //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, //New
                          blurRadius: 4.0,
                          offset: Offset(0, 0))
                    ],
                  ),
                  child: Container(
                    height: 50,
                    width: 220,
                    padding: EdgeInsets.symmetric(horizontal: 85, vertical: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white60,
                    ),
                    child: Text(
                      "$_count min",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onSurface: Colors.blue,
                      //primary: Colors.grey,
                      padding: EdgeInsets.all(10),
                      minimumSize: Size(65, 50),
                    ),
                    onPressed: _increaseCount,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 14,
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DurationButton(1),
                DurationButton(2),
                DurationButton(3),
                DurationButton(4),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Timer",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 15,
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 10,
                  child: Text(
                    "?",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Timer("15 min", 1),
                SizedBox(
                  width: 10,
                ),
                Timer("30 min", 2),
                SizedBox(
                  width: 10,
                ),
                Timer("Not now ", 3),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 150,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: Colors.green.shade100,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      // minimumSize: Size(50,20 ),
                    ),
                    child: Text(
                      "Start",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Mypayment()));
                      /*
                      Route route = MaterialPageRoute(
                          builder: (_) => Charging_screen(duration: _count));
                      Navigator.push(context, route);*/
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _timerButton = Colors.black;
  Widget Timer(String timer, int val) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Radio(
            // activeColor: Colors.blue,
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.blue;
              }
              return Colors.grey.shade800;
            }),
            value: val,
            groupValue: _value,
            onChanged: (int? value) {
              setState(() {
                _value = value;
              });
            }),
        // SizedBox(width: ,),
        Text(
          "$timer",
          style: TextStyle(fontSize: 15, color: Colors.white),
        )
      ],
    );
  }

  Widget DurationButton(int duration) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          primary: Colors.blue.shade100,
          padding: EdgeInsets.all(12),
          minimumSize: Size(70, 30)),
      onPressed: () {
        setState(() {
          _count = duration;
        });
      },
      child: Text(
        "$duration min",
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }
}
