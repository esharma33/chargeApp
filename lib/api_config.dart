var baseurl = "https://dev.powerstrip.in/api/v1/";

var otpgen = "${baseurl}auth/customer/generate-otp";
var otpverify = "${baseurl}auth/customer/verify-otp";
var tokenforshared; //used for shared prefs gets data from logintoken as a key
var device_id_url = "${baseurl}device/device-id/";
var subscription_url = "${baseurl}subscription/";

//var token = "";

var logintoken =
    ""; //used to store the customerauth token and also to store that token as a value in shared prefs

var review_url = "${baseurl}customer/review";
var postSubscription_url = "${baseurl}subscription/";
