import 'package:medical_app/Models/rating.dart';
import 'package:medical_app/Models/user.dart';

class DoctorRating
{
  User? user;
  Rating? rating;

  DoctorRating({this.user, this.rating});

  factory DoctorRating.fromJson(Map<String, dynamic> json) {

    return DoctorRating(
      user: User.fromJson(json),
      rating: Rating.fromJson(json),
    );
  }
}