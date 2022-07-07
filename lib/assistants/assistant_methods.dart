//import 'dart:_http';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chargeapp_master/User%20Details.dart';
import 'package:chargeapp_master/assistants/request_assistant.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../api_config.dart';

class AssistantMethods {

  static Future<String> searchAddressForGeographicCoOrdinates(Position position,
      context) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position
        .latitude},${position
        .longitude}&key=AIzaSyCf50CAnGbGnhY4nuYin8PqQNbxysuNDgk";
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

    try {
      Map? mapResponse;
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

       mapResponse = jsonDecode(response.body);
      token  = mapResponse?["customerAuthToken"];
      print(token);

      if (response.statusCode == 200) {
        return "success";
      } else {
        return "Otp didn't match";
      }
    } catch (err) {
      return "An error occured";
    }
  }

  static Future<String> device_info(String device_id) async{
    String url = device_id_url + device_id;
    Uri uri = Uri.parse((url));
    print(url);
    try {
      print("hellow");
      Map? responseData;

      var response = await http.get(
        uri,
        //  Uri.parse(device_id_url + "device-id=" + device_id),
          headers: <String, String>{
            //'Content-Type': 'application/json',

            'Content-Type': 'application/json',

            'CustomerAuthToken': '${token}',
          });

      responseData = jsonDecode(response.body);

      print(responseData!["message"] + " successsssssss");
      print("${responseData} result is hereeeeeee");
      if (responseData["message"] == "Success") {
        Map? userData;
       userData = responseData["device"];

        print(userData);
        site_area = userData!["site"];
        user_device_id = userData["device_id"];
        return "Success";

      } else {
        return "Wrong Device Id";
      }
    } catch (err) {
      print( "${err }is the errorrrrrrrrrrrr");
      return "error occured";
    }

  }
  static Future<String> check_subscribed(String device_id) async{
    String url = subscription_url + device_id;
    Uri uri = Uri.parse((url));
    print(url);
    try {
      print("hellow token is this ${token}");
      Map? responseData;

      var response = await http.get(
          uri,
          //  Uri.parse(device_id_url + "device-id=" + device_id),
          headers: <String, String>{
            //'Content-Type': 'application/json',

            'Content-Type': 'application/json',

            'CustomerAuthToken': '${token}',
          });

      responseData = jsonDecode(response.body);

      print(responseData!["message"] + " success");
      print("${responseData} result is here");
      if (responseData["message"] == "Success") {
        print(responseData);
         subscription= responseData["device"]["site_area"];

        return "Yes";

      } else {
        return "Not Subscribed";
      }
    } catch (err) {
      print( "${err} is the error");
      return "error occured";
    }

  }

  static Future<String> review_info(int rating, String review) async {

    try {
      // var map = new Map<String, dynamic>();
      // map['rating'] = rating;
      // map['review'] = review;
      //
      // final response = await http.post(
      //   Uri.parse('http/url/of/your/api'),
      //   body: map,
      // );
      var response = await http.post(
        Uri.parse(review_url),
          headers: <String, String>{
            'Content-Type': 'application/json',

            'CustomerAuthToken': '${token}',
           // HttpHeaders.contentTypeHeader: 'application/json'
          },
        body: jsonEncode(<String, dynamic>{
          'rating': rating,
          'review': review,
        }),
      );

      print("${jsonDecode(response.body)} feeedbackk!!!!");

     print("${token} is the tokennnnn");
      if (response.statusCode == 200) {

        return "success";
      } else {
        return "Feedback is not submitted. Kindly submit it again";
      }
    } catch (err) {
      print(err);
      return "An error occured";
    }
  }

}


