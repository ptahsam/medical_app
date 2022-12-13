
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int time = timestamp * 1000;
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