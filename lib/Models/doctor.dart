import 'package:medical_app/Models/rating.dart';
import 'package:medical_app/Models/user.dart';
import 'package:medical_app/Models/work.dart';

class Doctor
{
  User? user;
  Work? work;
  int? rating;

  Doctor({this.user, this.work, this.rating});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    
    return Doctor(
     user: User.fromJson(json),
     work: Work.fromJson(json),
     rating: json['rating'],
    );
  }
}