
import 'package:intl/intl.dart';
import 'package:medical_app/Models/doctor_booking.dart';
import 'package:medical_app/Models/doctor_rating.dart';
import 'package:shared_preferences/shared_preferences.dart';


String getAverageDoctorRatings(List<DoctorRating> doctorRatings){
  double userRatings = 0;

  for(var i = 0; i < doctorRatings.length; i++){
    DoctorRating doctorRating = doctorRatings[i];
    userRatings = userRatings + double.parse(doctorRating.rating!.rating!);
  }
  return (userRatings/doctorRatings.length).toString();
}

List<DoctorBooking> arrangeDoctorBooking(int active, List<DoctorBooking> bookingList){
  List<DoctorBooking> newList = [];

  if(active == 1){
    for(var i = 0; i < bookingList.length; i++){
      DoctorBooking doctorBooking = bookingList[i];
      if(doctorBooking.booking!.status == "booked" || doctorBooking.booking!.status == "confirmed"){
        newList.add(doctorBooking);
      }
    }
  }

  if(active == 2){
    for(var i = 0; i < bookingList.length; i++){
      DoctorBooking doctorBooking = bookingList[i];
      if(doctorBooking.booking!.status == "completed"){
        newList.add(doctorBooking);
      }
    }
  }

  if(active == 3){
    for(var i = 0; i < bookingList.length; i++){
      DoctorBooking doctorBooking = bookingList[i];
      if(doctorBooking.booking!.status == "cancelled"){
        newList.add(doctorBooking);
      }
    }
  }

  return newList;
}

saveUserId(String userid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userid', userid);
}

Future<String> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userID = prefs.getString('userid') != null?prefs.getString('userid')!:"";
  return userID;
}

String convertToFullDate(int timestamp){
  int time = timestamp.toString().length > 10?timestamp:timestamp * 1000;
  var d = DateFormat.d().format(DateTime.fromMillisecondsSinceEpoch(time));
  var m = DateFormat.M().format(DateTime.fromMillisecondsSinceEpoch(time));
  var y = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(time));

  var day = d.length == 1? '0' + d:d;
  var month = m.length == 1? '0' + m:m;

  return day + '/' + month + '/' + y;
}

String convertToBirthDate(int timestamp){
  return DateFormat.yMMMMd('en_US').format(DateTime.fromMillisecondsSinceEpoch(timestamp)).toString();
}

String convertToRatingtime(int stamp){
  int timestamp = stamp * 1000;
  var t = DateFormat('EEEE').format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  var d = DateFormat.d().format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  var m = DateFormat('MMMM').format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  var y = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  var cy = DateFormat('y').format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
  var cd = DateFormat.d().format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
  var cm = DateFormat('MMMM').format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
  if(y == cy){
    if(cm == m){
      if(cd == d){
        return "Today at " + convertToPMAM(timestamp);
      }
      if((int.parse(cd) - int.parse(d)) == 1){
        return "Yesterday at " + convertToPMAM(timestamp);
      }
      return convertToFullDate(timestamp);
    }
    return convertToFullDate(timestamp);
  }
  return convertToFullDate(timestamp);
}

String convertToPMAM(int timestamp) {
  var date = DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  return date.toString();
}