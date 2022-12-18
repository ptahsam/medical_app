import 'package:medical_app/Models/booking.dart';
import 'package:medical_app/Models/doctor.dart';

class DoctorBooking
{
  Doctor? doctor;
  Booking? booking;

  DoctorBooking({this.doctor, this.booking});

  factory DoctorBooking.fromJson(Map<String, dynamic> json) {

    Booking newBooking = Booking();
    newBooking.id = json['bid'];
    newBooking.scheduledate = json['scheduledate'];
    newBooking.schedule_start_time = json['schedule_start_time'];
    newBooking.schedule_end_time = json['schedule_end_time'];
    newBooking.status = json['status'];
    newBooking.notes = json['notes'];

    return DoctorBooking(
      booking: Booking.fromJson(json),
      doctor: Doctor.fromJson(json),
    );
  }
}