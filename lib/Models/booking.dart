class Booking
{
  int? id;
  String? scheduledate;
  String? schedule_start_time;
  String? schedule_end_time;
  String? status;
  String? notes;

  Booking({this.id, this.scheduledate, this.schedule_start_time, this.schedule_end_time, this.status, this.notes});

  factory Booking.fromJson(Map<String, dynamic> json) {

    return Booking(
      id: json['bid'],
      scheduledate: json['scheduled_date'],
      schedule_start_time: json['schedule_start_time'],
      schedule_end_time: json['schedule_end_time'],
      status: json['status'],
      notes: json['notes'],
    );
  }
}