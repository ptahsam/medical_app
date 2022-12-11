import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/config/palette.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
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
                expandedHeight: MediaQuery.of(context).size.height * 0.25,
                collapsedHeight: 100.0,
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
                        'Dr Phil Molly',
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
                        'Physician',
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
                        "Doctor Phil Molly is an experienced specialist who is constantly working to improve his skills.",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Palette.textColor,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Row(
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
                                "5.0",
                                style: TextStyle(
                                  color: Palette.greyText,
                                ),
                              ),
                              Text(
                                "(122)",
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
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        child: AnimatedList(
                          initialItemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, int index, animation){
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
                                      "Peter Samuel",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "1 day ago",
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
                                            "5.0",
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
                                    "Many thanks to Doctor Phil Molly. He is a professional, competent doctor",
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
                            "Lotus Medical Center",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "3516 W. Gray St. Ultica, New York.",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Palette.textLight,
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
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
                        "KES. 2000",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0,),
                  Container(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
