import 'package:chargeapp_master/Screens/charge_duration.dart';
import 'package:chargeapp_master/Screens/qr_sacn_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
        hasScrollBody: false,
        child: Padding(
          padding: EdgeInsets.only(top: 22, bottom: 100, right: 20, left: 20),
          child: Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade900, // darker color
                    ),
                    BoxShadow(
                      color: Colors.black, // background color
                      spreadRadius: -3.0,
                      blurRadius: 12.0,
                    ),
                  ],

                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // only(
                  //     bottomLeft: Radius.circular(10.0),
                  //     topLeft: Radius.circular(10.0)),
                  //  color: Colors.grey.shade900,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50,),
                    Text(
                      "  Charging session summary",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    BuildRow("Time Selected", "${widget.duration} min"),
                    SizedBox(
                      height: 15,
                    ),
                    BuildRow("Charge Time left",
                        "${widget.mins}  min and ${widget.sec} sec"),
                   ],),
              ),

              Align(
                alignment: FractionalOffset.bottomCenter,

                    child: Container(
                      height: 60,
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: Colors.green.shade200,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          // minimumSize: Size(50,20 ),
                        ),
                        child: const Text(
                          "Done",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              elevation: 12.0,
                              insetPadding: EdgeInsets.all(20),
                              backgroundColor: Color(0xff1B1D20),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                height: 500,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xff1B1D20),
                                ),
                                child: Stack(
                                  children: [
                                    Column(children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Qr_scan_screen()));
                                              },
                                              icon: Icon(Icons.arrow_back),
                                              splashColor: Colors.black,
                                              color: Colors.white,
                                              iconSize: 32,
                                            ),
                                          ]),
                                      const Text(
                                        "How was your experience?",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      RatingBar(
                                        initialRating: 0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        //allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 6.0),
                                        ratingWidget: RatingWidget(
                                          full: const Icon(
                                            Icons.star,
                                            size: 14,
                                            color: Colors.amber,
                                          ),
                                          half: const Icon(
                                            Icons.star_border_outlined,
                                            size: 14,
                                            color: Colors.amber,
                                          ),
                                          empty: const Icon(
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey, // darker color
                                            ),
                                            BoxShadow(
                                              color:
                                                  Colors.white, // background color
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
                                            hintStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade500),
                                          ),
                                        ),
                                      ),
                                      ],
                                    ),

                                Align(
                                  alignment: FractionalOffset.bottomCenter,
                                        child: Container(
                                            height: 60,
                                            width: double.maxFinite,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                            String feedBack =
                                                _textDeviceController.text;
                                            if (feedBack.length == 0) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please type your feedBack");
                                            } else {
                                              var result = await AssistantMethods
                                                  .review_info(rating, feedBack);
                                              print(result +
                                                  "------------------------------------");
                                              if (result == "success") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Your feedBack has been submitted.");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Qr_scan_screen()));
                                                print("submitted the feedback");
                                              } else if (result ==
                                                  "Feedback is not submitted. Kindly submit it again") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Feedback is not submitted. Kindly submit it again.");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "An error occured");
                                                //   print("logging in");
                                              }
                                            }
                                              },
                                              style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            primary: Colors.green.shade200,
                                            // padding: EdgeInsets.symmetric(
                                            //     horizontal: 20, vertical: 15),
                                            // // minimumSize: Size(50,20 ),
                                               ),
                                              child: const Text(
                                            "Submit",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                              ),
                                            )
                                        ),
                                      )
                                    ]
                                 ),
                              ),
                               ),
                          );
                            },
                               ),
                    ),
              ),
            ],
                                  ),
                                ),
                              ),
      ],
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
