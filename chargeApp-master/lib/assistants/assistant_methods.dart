import 'dart:convert';
import 'dart:developer';

import 'package:charging_app/api_config.dart';
import 'package:charging_app/assistants/request_assistant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class AssistantMethods {
  static Future<String> searchAddressForGeographicCoOrdinates(
      Position position, context) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyCf50CAnGbGnhY4nuYin8PqQNbxysuNDgk";
    String humanReadableAddress = "";

    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);

    if (requestResponse != "Error Occurred, Failed. No Response.") {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];
    }

    return humanReadableAddress;
  }

  static Future<String> generateOtp(String mobilenumber) async {
    var response = await http.post(
      Uri.parse(otpgen),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile_number': mobilenumber,
      }),
    );
    if (response.statusCode == 200) {
      log("${response.body}");
      return "success";
    } else {
      return "failure";
    }
  }

  static Future<String> validateOtp(String mobilenumber, String otp) async {
    var response = await http.post(
      Uri.parse(otpverify),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'otp': otp,
        'mobile_number': mobilenumber,
      }),
    );

    if (response.statusCode == 200) {
      return "success";
    } else {
      return "Otp didn't match";
    }
  }
}
