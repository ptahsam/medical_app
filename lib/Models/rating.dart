class Rating
{
  int? id;
  String? rating;
  String? comment;
  String? date_added;

  Rating({this.id, this.rating, this.comment, this.date_added});

  factory Rating.fromJson(Map<String, dynamic> json) {

    return Rating(
      id: json['rid'],
      rating: json['rating'],
      comment: json['comment'],
      date_added: json['rating_date'],
    );
  }
}