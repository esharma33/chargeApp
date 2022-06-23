import 'package:charging_app/Screens/payment.dart';
import 'package:flutter/material.dart';

class Charging_summary extends StatefulWidget {
  int duration;
  String mins;
  String sec;
  Charging_summary(
      {Key? key, required this.duration, required this.mins, required this.sec})
      : super(key: key);

  @override
  _Charging_summaryState createState() => _Charging_summaryState();
}

class _Charging_summaryState extends State<Charging_summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 22, bottom: 20, right: 20, left: 20),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Charging session summary",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 15,
                ),
                BuildRow("Time Selected", "${widget.duration} mins"),
                SizedBox(
                  height: 10,
                ),
                BuildRow("Charge Time",
                    "${widget.mins}  mins and ${widget.sec} sec"),
                SizedBox(
                  height: 80,
                ),
                Text(
                  "How was your experience?",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                width: double.infinity,
                child: Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: Colors.green.shade200,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      // minimumSize: Size(50,20 ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {
                      print("Submitted the feedback");
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildRow(String parameter, String value) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            parameter,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
