class User
{
  int? id;
  String? fullname;
  String? phonenumber;
  String? email;
  String? role;
  String? photo;
  String? birthdate;
  String? street_address;
  String? city;
  String? zipcode;
  String? date_joined;

  User({this.id, this.fullname, this.phonenumber, this.email, this.role, this.photo, this.birthdate, this.street_address, this.city, this.zipcode, this.date_joined});

  factory User.fromJson(Map<String, dynamic> json) {

    return User(
      id: json['uid'],
      fullname: json['fullname'],
      phonenumber: json['phonenumber'],
      email: json['email'],
      role: json['role'],
      photo: json['photo'],
      birthdate: json['birthdate'],
      street_address: json['street_address'],
      city: json['city'],
      zipcode: json['zipcode'],
      date_joined: json['date_joined'],
    );
  }
}