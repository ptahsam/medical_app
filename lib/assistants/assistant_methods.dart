
import 'package:medical_app/DataHandler/appdata.dart';
import 'package:medical_app/Models/doctor.dart';
import 'package:medical_app/Models/user.dart';
import 'package:medical_app/Models/work.dart';
import 'package:medical_app/assistants/request_assistant.dart';
import 'package:provider/provider.dart';

class AssistantMethods
{

  static getUserData(context, String userid) async{
    var params = {
      'getUserData': '1',
      'userid': '${userid}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed" && response != "NO_DATA"){
      User user = User.fromJson(response);

      Provider.of<AppData>(context, listen: false).updateUser(user, true);
    }else{
      User user = User();
      Provider.of<AppData>(context, listen: false).updateUser(user, false);
    }
  }

  static getDoctorData(context, String doctorid) async{
    var params = {
      'getDoctorData': '1',
      'doctorid': '${doctorid}',
    };

    var response = await RequestAssistant.getRequest(params);

    //print(response);

    if(response != "failed" && response != "NO_DATA"){
      Work work = Work.fromJson(response);

      Provider.of<AppData>(context, listen: false).updateWork(work, true);
    }else{
      Work work = Work();
      Provider.of<AppData>(context, listen: false).updateWork(work, false);
    }
  }

  static Future<String> saveDoctorDetails(context, String doctorid, String title, String field, String worktype, String education, String description, String facilityname, String location, String consultation_fee) async {
    String data = "";

    var params = {
      'saveDoctorDetails': '1',
      'doctorid': '${doctorid}',
      'title': '${title}',
      'field': '${field}',
      'worktype': '${worktype}',
      'education': '${education}',
      'description': '${description}',
      'facilityname': '${facilityname}',
      'location': '${location}',
      'consultation_fee': '${consultation_fee}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response.toString() == "SUCCESSFULLY_UPDATED" || response.toString() == "SUCCESSFULLY_ADDED"){
      await getDoctorData(context, doctorid);
      response = "SUCCESS";
    }

    data = response;

    return data;
  }

  static Future<String> updateUser(context, String userid, String fullname, String phonenumber, String email, String photo, String birthdate, String streetaddress, String city, String zipcode) async {
    String data = "";

    var params = {
      'updateUser': '1',
      'userid': '${userid}',
      'fullname': '${fullname}',
      'phonenumber': '${phonenumber}',
      'email': '${email}',
      'photo': '${photo}',
      'birthdate': '${birthdate}',
      'streetaddress': '${streetaddress}',
      'city': '${city}',
      'zipcode': '${zipcode}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response.toString() == "SUCCESSFULLY_UPDATED"){
      await getUserData(context, userid);
      response = "SUCCESS";
    }

    data = response;

    return data;
  }

  static Future<String> loginUser(context, String identifier, String password) async{
    String data = "";
    var params = {
      'loginUser': '1',
      'identifier': '${identifier}',
      'password': '${password}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response.toString() != "failed" && response.toString() != "NOT_REGISTERED" && response.toString() != "PASSWORD_NOT_MATCHED"){

      User user = User.fromJson(response);

      Provider.of<AppData>(context, listen: false).updateUser(user, true);
      data = "LOGGED_IN";
    }else{
      data = response.toString();
    }
    return data;
  }

  static Future<String> registerUser(context, String identifier, String password, String role) async{
    String data = "";
    var params = {
      'registerUser': '1',
      'identifier': '${identifier}',
      'password': '${password}',
      'role': '${role}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed"){
      data = response.toString();
    }else{
      data = "failed";
    }
    return data;
  }

  static getAllDoctors(context) async{
    var params = {
      'getAllDoctors': '1',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed" && response != "NO_DATA"){
      final items = response.cast<Map<String, dynamic>>();

      List<Doctor> doctors = items.map<Doctor>((json) {
        return Doctor.fromJson(json);
      }).toList();


      //print(doctors.first.work!.description.toString());

      Provider.of<AppData>(context, listen: false).updateDoctorsList(doctors);
    }else if(response == "NO_DATA" || response == "failed"){
      List<Doctor> doctors = [];
      Provider.of<AppData>(context, listen: false).updateDoctorsList(doctors);
    }
  }
}