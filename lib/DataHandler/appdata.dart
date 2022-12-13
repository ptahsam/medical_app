import 'package:flutter/foundation.dart';
import 'package:medical_app/Models/doctor.dart';
import 'package:medical_app/Models/user.dart';
import 'package:medical_app/Models/work.dart';

class AppData extends ChangeNotifier
{
  User? user;
  Work? work;
  List<Doctor>? doctorsList;

  void updateUser(User loggedUser, bool hasData)
  {
    if(hasData){
      user = loggedUser;
    }else{
      user = null;
    }
    notifyListeners();
  }

  void updateWork(Work workProfile, bool hasData)
  {
    if(hasData){
      work = workProfile;
    }else{
      work = null;
    }
    notifyListeners();
  }

  void updateDoctorsList(List<Doctor> listDoctors)
  {
    doctorsList = listDoctors;
    notifyListeners();
  }
}