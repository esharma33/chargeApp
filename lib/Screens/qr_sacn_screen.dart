import 'dart:io' show Platform;
import 'package:chargeapp_master/Screens/Subscription_Screen.dart';
import 'package:chargeapp_master/Screens/charge_duration.dart';
import 'package:chargeapp_master/Screens/device_id_input_screen.dart';
import 'package:chargeapp_master/assistants/assistant_methods.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Qr_scan_screen extends StatefulWidget {
  const Qr_scan_screen({Key? key}) : super(key: key);

  @override
  _Qr_scan_screenState createState() => _Qr_scan_screenState();
}

class _Qr_scan_screenState extends State<Qr_scan_screen> {
  Barcode? result;
  String device_id = "";
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void readQr() async {
    if (result != null) {
      controller?.scannedDataStream
          .listen((result) => setState(() => this.result = result));
           device_id = result!.code.toString();

      var response = await AssistantMethods.device_info(device_id);
      print(response +  "------------------------------------");
      if(device_id=="")
        Fluttertoast.showToast(msg: "Please enter the device id.");

      if(response == "Success"){
        Fluttertoast.showToast(msg: "logging in");
        print("logging in");
        var subscribed = await AssistantMethods.check_subscribed(device_id);
        if(subscribed == "Yes"){
          Route route = MaterialPageRoute(
              builder: (_) => Charge_duration_screen());
          Navigator.push(context, route);

        }else {
          Route route = MaterialPageRoute(
              builder: (_) => Subscriptions());
          Navigator.push(context, route);
        }
      }

      else if(response == "Wrong Device Id") {
        Fluttertoast.showToast(
            msg: "The device Id you enetered does not exist.");
      }
      else{
        Fluttertoast.showToast(msg: "An error occured");
        //   print("logging in");
      }
        }
      controller!.dispose();
    }


  @override
  Widget build(BuildContext context) {
    readQr();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 165,
              borderWidth: 5,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Positioned(
            top: 40,
            right: 10,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.clear_rounded,
                  color: Colors.white,
                  size: 20.0,
                )),
          ),
          Positioned(
            top: 100,
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.8,
              // height: 40,
              // decoration: BoxDecoration(
              //   boxShadow: [
              //     BoxShadow(color: Colors.blue.shade900, spreadRadius: 3),
              //   ],
              // ),
              color: Colors.blue,
              child: Text(
                "Scan the QR Code or enter device ID",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                top: 30,
                bottom: 70,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                color: Colors.black,
              ),
              child: Row(
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
                          // color: Colors.black,
                        ),

                        // height: 60,
                        // width: 100,
                        padding: EdgeInsets.all(18),
                        child: Text(
                          "Enter device ID here",
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        // minimumSize: Size(50,20 ),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Route route =
                            MaterialPageRoute(builder: (_) => DeviceIdScreen());
                        Navigator.push(context, route);
                      },
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
