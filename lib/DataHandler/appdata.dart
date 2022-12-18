import 'package:flutter/foundation.dart';
import 'package:medical_app/Models/doctor.dart';
import 'package:medical_app/Models/doctor_booking.dart';
import 'package:medical_app/Models/doctor_rating.dart';
import 'package:medical_app/Models/user.dart';
import 'package:medical_app/Models/work.dart';

class AppData extends ChangeNotifier
{
  User? user;
  Work? work;
  List<Doctor>? doctorsList;
  List<DoctorBooking>? doctorBookingList;
  List<DoctorRating>? doctorRatingList;

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

  void updateDoctorBookingList(List<DoctorBooking> listDoctorBooking)
  {
    doctorBookingList = listDoctorBooking;
    notifyListeners();
  }

  void updateDoctorRatingList(List<DoctorRating> listDoctorRating)
  {
    doctorRatingList = listDoctorRating;
    notifyListeners();
  }
}