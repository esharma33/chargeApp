import 'package:chargeapp_master/Screens/charge_duration.dart';
import 'package:chargeapp_master/Screens/Subscription_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../assistants/assistant_methods.dart';

class DeviceIdScreen extends StatefulWidget {
  DeviceIdScreen({Key? key}) : super(key: key);

  @override
  _DeviceIdScreenState createState() => _DeviceIdScreenState();
}

class _DeviceIdScreenState extends State<DeviceIdScreen> {
  final _textDeviceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 30, left: 20, right: 20),
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        height: 50,
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

                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0)),
                          //  color: Colors.grey.shade900,
                        ),

                        // height: 60,
                        // width: 100,
                        padding: EdgeInsets.all(18),
                        child: TextField(
                          controller: _textDeviceController,
                          decoration: InputDecoration(
                            //labelText: "Enter device ID here ",
                            hintText: "Enter device Id here",

                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0)),
                          ),
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 11),
                          // minimumSize: Size(50,20 ),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          String device_id = _textDeviceController.text;
                          if (device_id.length == 0) {
                            Fluttertoast.showToast(
                                msg: "Please enter Device Id");
                          } else {
                            var result =
                                await AssistantMethods.device_info(device_id);
                            print(result +
                                "------------------------------------");
                            if (result == "Success") {
                              Fluttertoast.showToast(msg: "logging in");
                              print("logging in");
                              var subscribed =
                                  await AssistantMethods.check_subscribed(
                                      device_id);
                              if (subscribed == "Yes") {
                                Route route = MaterialPageRoute(
                                    builder: (_) => Charge_duration_screen());
                                Navigator.push(context, route);
                              } else {
                                Route route = MaterialPageRoute(
                                    builder: (_) => Subscriptions());
                                Navigator.push(context, route);
                              }
                            } else if (result == "Wrong Device Id") {
                              Fluttertoast.showToast(
                                  msg:
                                      "The device Id you entered does not exist.");
                            } else {
                              Fluttertoast.showToast(msg: "An error occured");
                              //   print("logging in");
                            }
                          }
                        }
                        //  },
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
