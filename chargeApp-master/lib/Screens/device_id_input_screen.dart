import 'package:charging_app/Screens/Subscription_Screen.dart';
import 'package:charging_app/Screens/charge_duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceIdScreen extends StatefulWidget {
  const DeviceIdScreen({Key? key}) : super(key: key);

  @override
  _DeviceIdScreenState createState() => _DeviceIdScreenState();
}

class _DeviceIdScreenState extends State<DeviceIdScreen> {
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
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, //New
                        blurRadius: 4.0,
                        offset: Offset(0, 0))
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0)),
                            color: Colors.black,
                          ),

                          // height: 60,
                          // width: 100,
                          padding: EdgeInsets.all(18),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Enter device ID here ",
                              labelStyle:
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
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (_) => Subscriptions());
                          Navigator.push(context, route);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
