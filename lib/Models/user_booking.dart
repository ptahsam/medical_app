import 'package:medical_app/Models/booking.dart';
import 'package:medical_app/Models/user.dart';

class UserBooking
{
  User? user;
  Booking? booking;

  UserBooking({this.user, this.booking});

  factory UserBooking.fromJson(Map<String, dynamic> json) {

    return UserBooking(
      user: User.fromJson(json),
      booking: Booking.fromJson(json),
    );
  }
}