import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../assistants/assistant_methods.dart';

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
  final _textDeviceController = TextEditingController();
  int rating = 0;
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
      body: SingleChildScrollView(
        child: Padding(
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
                    height: 25,
                  ),
                  BuildRow("Time Selected", "${widget.duration} min"),
                  SizedBox(
                    height: 10,
                  ),
                  BuildRow(
                      "Charge Time", "${widget.mins}  min and ${widget.sec} sec"),
                  SizedBox(
                    height: 30,
                  ),
                  BuildRow("Total Cost", " ₹ 35.42"),
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
                  SizedBox(
                    height: 25,
                  ),
                  RatingBar(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    //allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 6.0),
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      half: Icon(
                        Icons.star_border_outlined,
                        size: 14,
                        color: Colors.amber,
                      ),
                      empty: Icon(
                        Icons.star_border_outlined,
                        size: 14,
                        color: Colors.amber,
                      ),
                    ),
                    onRatingUpdate: (rating) {
                      rating = rating;
                      print(rating);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey, // darker color
                        ),
                        BoxShadow(
                          color: Colors.white, // background color
                          spreadRadius: -7.0,
                          blurRadius: 12.0,
                        ),
                      ],
                    ),
                    child: TextField(
                    //  scrollPadding: EdgeInsets.only(bottom: 100),
                      maxLines: 6,
                      controller: _textDeviceController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Write your feedback here.",
                        hintStyle:
                            TextStyle(fontSize: 16, color: Colors.grey.shade500),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
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
                        onPressed: () async {
                          String feedBack = _textDeviceController.text;
                          if(feedBack == ""){
                            Fluttertoast.showToast(
                                msg: "Please type in your feedBack");
                          }

                          var result = await AssistantMethods.review_info(rating,feedBack);
                          print(result + "------------------------------------");
                          if(result == "success") {
                            Fluttertoast.showToast(
                                msg: "Your feedBack has been submitted.");
                            print("submitted the feedback");
                          }
                          else if(result == "Feedback is not submitted. Kindly submit it again"){
                            Fluttertoast.showToast(msg: "Feedback is not submitted. Kindly submit it again.");

                          }
                          else{
                            Fluttertoast.showToast(msg: "An error occured");
                            //   print("logging in");
                          }

                          //print("Submitted the feedback");
                        },
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget BuildRow(String parameter, String value) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
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
