import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/DataHandler/appdata.dart';
import 'package:medical_app/Models/doctor.dart';
import 'package:medical_app/Models/doctor_rating.dart';
import 'package:medical_app/assistants/assistant_methods.dart';
import 'package:medical_app/config/config.dart';
import 'package:medical_app/config/palette.dart';
import 'package:medical_app/sharedWidgets/book_appointment.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DoctorDetails extends StatefulWidget {
  final Doctor doctor;
  const DoctorDetails({
    Key? key,
    required this.doctor
  }) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  TextEditingController commentEditingController = TextEditingController();

  bool ratingChanged = false;
  double userRating = 3.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AssistantMethods.getDoctorRatings(context, widget.doctor.user!.id!.toString());
  }

  @override
  Widget build(BuildContext context) {
    List<DoctorRating> doctorRatingList = Provider.of<AppData>(context).doctorRatingList!=null?Provider.of<AppData>(context).doctorRatingList!:[];
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            shadowColor: Colors.transparent,
            leading: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white,
                ),
              ),
            ],
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            collapsedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  SizedBox(height: 60.0,),
                  Container(
                    margin: EdgeInsets.only(right: 12.0),
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/profile.jpg",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    '${widget.doctor.work!.title! + " " + widget.doctor.user!.fullname!}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    '${widget.doctor.work!.field!}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Palette.greyLight1,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.55),
                        ),
                        child: Icon(
                          FontAwesomeIcons.phone,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.55),
                        ),
                        child: Icon(
                          FontAwesomeIcons.message,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About doctor",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Text(
                    '${widget.doctor.work!.description!}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Palette.textColor,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  doctorRatingList.isNotEmpty?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Reviews",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10.0,),
                          Icon(
                            Icons.star,
                            color: Palette.orange1,
                            size: 15.0,
                          ),
                          SizedBox(width: 3.0,),
                          Text(
                            "${getAverageDoctorRatings(doctorRatingList)}",
                            style: TextStyle(
                              color: Palette.greyText,
                            ),
                          ),
                          Text(
                            "(${doctorRatingList.length})",
                            style: TextStyle(
                              color: Palette.textLight,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "View all",
                        style: TextStyle(
                          color: Palette.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ):SizedBox.shrink(),
                  SizedBox(height: 10.0,),
                  Container(
                    padding: EdgeInsets.only(bottom: 20.0),
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    child: doctorRatingList.isNotEmpty?AnimatedList(
                      initialItemCount: doctorRatingList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, int index, animation){
                        DoctorRating doctorRating = doctorRatingList[index];
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          margin: EdgeInsets.only(right: 10.0),
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[100]!.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  margin: EdgeInsets.only(right: 12.0),
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/profile.jpg",
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "${doctorRating.user!.fullname!}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "${convertToRatingtime(int.parse(doctorRating.rating!.date_added!))}",
                                  style: TextStyle(
                                    color: Palette.textLight,
                                  ),
                                ),
                                trailing: Container(
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Palette.orange1.withOpacity(0.35),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Palette.orange1,
                                        size: 15.0,
                                      ),
                                      SizedBox(width: 3.0,),
                                      Text(
                                        "${doctorRating.rating!.rating!}",
                                        style: TextStyle(
                                          color: Palette.greyText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                "${doctorRating.rating!.comment!}",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Palette.textColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ):Center(
                      child: Text(
                        "No ratings currently",
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100]!.withOpacity(0.75),
                        ),
                        child: Icon(
                          Icons.location_pin,
                          color: Palette.mainColor,
                          size: 28.0,
                        ),
                      ),
                      title: Text(
                        '${widget.doctor.work!.facility_name!}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${widget.doctor.work!.location!}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Palette.textLight,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Add Ratings",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ratingChanged?ElevatedButton(
                        onPressed: () async {
                          String response = await AssistantMethods.saveDoctorRating(context, widget.doctor.user!.id!.toString(), await getUserId(), userRating.toString(), commentEditingController.text);

                          if(response == "SUCCESS"){
                            setState(() {
                              userRating = 3.0;
                              ratingChanged = false;
                              commentEditingController.text = "";
                            });
                          }
                        },
                        child: Text(
                          "Save",
                        ),
                      ):SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: RatingBar.builder(
                      initialRating: userRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 34,
                      itemPadding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Palette.mainColor,
                        size: 18.0,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          userRating = rating;
                          ratingChanged = true;
                        });
                      },
                    ),
                    subtitle: TextField(
                      controller: commentEditingController,
                      minLines: 3,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: "Leave a comment",
                        hintStyle: TextStyle(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0, bottom: 40.0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Consultation fee",
                        style: TextStyle(
                          color: Palette.textColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'KES. ${widget.doctor.work!.consultation_fee!}/hr',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: BookAppointment(doctor: widget.doctor,)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 90,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Palette.mainColor,
                      ),
                      child: Center(
                        child: Text(
                          "Book Appointment",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
