import 'package:chargeapp_master/Screens/charge_duration.dart';
import 'package:chargeapp_master/Screens/payment.dart';
import 'package:flutter/material.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  String _value = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B1D20),
      body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    "Subscription Plans",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 120,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black,
                              spreadRadius: .5,
                              blurRadius: 4,
                              offset: Offset(0, 5)),
                          BoxShadow(
                              color: Colors.grey.shade800,
                              spreadRadius: .3,
                              blurRadius: 4,
                              offset: Offset(-5, 0))
                        ],
                        color: Color(0xff1B1D20),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                  activeColor: Colors.blue,
                                  value: "Basic",
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value as String;
                                    });
                                  }),
                              const Text(
                                "Basic",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              Container(
                                child: const Center(
                                  child: Text(
                                    "Recommended",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width - 270),
                                height: 30,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      Color(0xffB6F2CE),
                                      Color(0xff1FA7FE),
                                    ])),
                              )
                            ],
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "₹199/- per month",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 10),
                            child: Text(
                              "Upto 60 hours of charging per month ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 120,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xffB6F2CE),
                          Color(0xff1FA7FE),
                        ]),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black,
                              spreadRadius: .5,
                              blurRadius: 4,
                              offset: Offset(0, 5)),
                          BoxShadow(
                              color: Colors.grey.shade800,
                              spreadRadius: .3,
                              blurRadius: 4,
                              offset: Offset(-5, 0))
                        ],
                        color: Color(0xff1B1D20),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                  activeColor: Colors.blue,
                                  value: "Standard",
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value as String;
                                    });
                                  }),
                              const Text(
                                "Standard",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                child: const Center(
                                  child: Text(
                                    "Best Seller",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width - 300),
                                height: 30,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Color(0xff1B1D20),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )
                            ],
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "₹699/- per month",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 10),
                            child: Text(
                              "Upto 240 hours of charging per month ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 120,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black,
                              spreadRadius: .3,
                              blurRadius: 4,
                              offset: Offset(0, 5)),
                          BoxShadow(
                              color: Colors.grey.shade800,
                              spreadRadius: .1,
                              blurRadius: 3,
                              offset: Offset(-5, 0))
                        ],
                        color: Color(0xff1B1D20),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                  activeColor: Colors.blue,
                                  value: "Premium",
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value as String;
                                    });
                                  }),
                              const Text(
                                "Premium",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              )
                            ],
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "₹1299/- per month",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 10),
                            child: Text(
                              "Upto 360 hours of charging per month ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ]),
                  ),
                   SizedBox(
                    height: 40,
                  ),
                ],
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  width: double.maxFinite,
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Color(0xffB6F2CF)),
                      onPressed: () {


                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Mypayment()));
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )),
                ),
              )
            ],
          )
           ),

    );
  }
}
