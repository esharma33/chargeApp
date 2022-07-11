import 'dart:async';

import 'package:chargeapp_master/Screens/Subscription_Screen.dart';
import 'package:chargeapp_master/Screens/qr_sacn_screen.dart';
import 'package:chargeapp_master/assistants/assistant_methods.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class VerifyOtp extends StatefulWidget {
  final String mobilenum;
  const VerifyOtp({Key? key, required this.mobilenum}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  bool isAPICallProcess = false;
  Duration myDuration = Duration(seconds: 10);
  String mins = "";
  String sec = "";
  String enteredotp = "";
  bool isresendVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _duration = widget.duration;

    startTimer();
  }

  Timer? countdownTimer;
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer?.cancel();
        isresendVisible = true;
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xff1B1D20),
        resizeToAvoidBottomInset: false,
        body: ProgressHUD(
          inAsyncCall: isAPICallProcess,
          key: UniqueKey(),
          opacity: .3,
          child: Container(
            padding: EdgeInsets.only(top: 140),
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage("assets/Background.png")),
              gradient: LinearGradient(
                colors: [
                  Color(0xff292E37),
                  Color(0xff090A0C),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 13,
                ),
                const Text(
                  "Yay! one step closer to greenery",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(
                      top: 42, bottom: 42, left: 16, right: 16),
                  height: 376,
                  width: 315,
                  decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.dstOut,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 3,
                            blurStyle: BlurStyle.outer),
                      ],
                      color: const Color(0xff1B1D20),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      PinFieldAutoFill(
                        //unfocus and clear otp fields
                        keyboardType: TextInputType.number,
                        decoration: UnderlineDecoration(
                          textStyle:
                              TextStyle(fontSize: 20, color: Colors.white),
                          colorBuilder: FixedColorBuilder(
                            Colors.white.withOpacity(1),
                          ),
                        ),
                        currentCode: enteredotp,
                        codeLength: 6,
                        onCodeChanged: (code) {
                          if (code!.length == 6) {
                            enteredotp = code;
                            print(enteredotp);
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 58,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffB6F2CF),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (enteredotp.length != 6) {
                              Fluttertoast.showToast(
                                  msg: "Please enter valid OTP");
                            } else if (enteredotp.length == 6) {
                              var result = await AssistantMethods.validateOtp(
                                  widget.mobilenum, enteredotp);
                              if (result == "success") {
                                Fluttertoast.showToast(
                                    msg: "OTP Verified Successfully");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Qr_scan_screen()));
                              } else {
                                Fluttertoast.showToast(
                                    msg: "The OTP did not match");
                              }
                            }
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BuildTime(),
                              Visibility(
                                  visible: isresendVisible,
                                  child: TextButton(
                                    onPressed: () async {
                                      print(widget.mobilenum);
                                      var output = AssistantMethods.generateOtp(
                                          widget.mobilenum);
                                      //log("${widget.mobilenum}");

                                      if (output == "success") {
                                        Fluttertoast.showToast(
                                            msg: "OTP Resent Successfully");
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Problem In Resending OTP");
                                      }
                                    },
                                    child: Text("Resend OTP"),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: const <Widget>[
                        Expanded(
                            child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        )),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "OR",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                            child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        )),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 58,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: TextButton(
                            onPressed: () {
                              print(widget.mobilenum);
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(
                                      "assets/googleicon.png",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 13,
                                  ),
                                  Text(
                                    "Login using Google",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )
                                ]),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget BuildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final seconds = twoDigits(myDuration.inSeconds.remainder(60));
    return Visibility(
      visible: !isresendVisible,
      child: Text(
        ":$seconds",
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
