class Work
{
  int? id;
  String? title;
  String? field;
  String? work_type;
  String? education;
  String? description;
  String? facility_name;
  String? location;
  String? consultation_fee;

  Work({this.id, this.title, this.field, this.work_type, this.education, this.description, this.facility_name, this.location, this.consultation_fee});

  factory Work.fromJson(Map<String, dynamic> json) {

    return Work(
      id: json['did'],
      title: json['title'],
      field: json['field'],
      work_type: json['work_type'],
      education: json['education'],
      description: json['description'],
      facility_name: json['facility_name'],
      location: json['location'],
      consultation_fee: json['consultation_fee'],
    );
  }
}