import 'package:medical_app/Models/user.dart';
import 'package:medical_app/Models/work.dart';

class Doctor
{
  User? user;
  Work? work;

  Doctor({this.user, this.work});

  factory Doctor.fromJson(Map<String, dynamic> json) {

    User newUser = User();
    newUser.id = json['did'];
    newUser.fullname = json['fullname'];
    newUser.phonenumber = json['phonenumber'];
    newUser.email = json['email'];
    newUser.role = json['role'];
    newUser.photo = json['photo'];
    newUser.birthdate = json['birthdate'];
    newUser.street_address = json['street_address'];
    newUser.city = json['city'];
    newUser.zipcode = json['zipcode'];
    newUser.date_joined = json['date_joined'];

    Work newWork = Work();
    newWork.id = json['did'];
    newWork.title = json['title'];
    newWork.field = json['field'];
    newWork.work_type = json['work_type'];
    newWork.education = json['education'];
    newWork.description = json['description'];
    newWork.facility_name = json['facility_name'];
    newWork.location = json['location'];
    newWork.consultation_fee = json['consultation_fee'];
    return Doctor(
     user: newUser,
     work: newWork,
    );
  }
}