import 'package:flutter/material.dart';
import 'package:medical_app/DataHandler/appdata.dart';
import 'package:medical_app/Models/doctor.dart';
import 'package:medical_app/Models/user.dart';
import 'package:medical_app/assistants/assistant_methods.dart';
import 'package:medical_app/config/palette.dart';
import 'package:medical_app/sharedWidgets/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isClinicVisit = true;

  List<String> symptoms = [
    'Fever',
    'Chills and sweats',
    'Coughs',
    'Sore throat',
    'Shortness of breath',
    'Nasal congestion',
    'Stiff neck',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData(){
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AppData>(context).user!;
    List<Doctor> doctorsList = Provider.of<AppData>(context).doctorsList!=null?Provider.of<AppData>(context).doctorsList!:[];
    return Scaffold(
      backgroundColor: Colors.white70,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leadingWidth: 0,
            centerTitle: false,
            title: Text(
              user.fullname!,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              user.photo != null && user.photo != ""?InkWell(
                onTap: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: UserProfile()));
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: ProfileAvatar(imageUrl: user.photo!, hasBorder: true, radius: 28.0, borderWidth: 27.0,)
                ),
              ):InkWell(
                onTap: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: UserProfile()));
                },
                child: Container(
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
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 40.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          if(!isClinicVisit){
                            isClinicVisit = true;
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: isClinicVisit?Palette.mainColor.withOpacity(0.75):Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Palette.textColorD,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isClinicVisit?Colors.white:Palette.greyLight,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Palette.mainColor,
                                size: 30.0,
                              ),
                            ),
                            SizedBox(height: 25.0,),
                            Text(
                              "Clinic visit",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: isClinicVisit?Colors.white:Colors.black,
                              ),
                            ),
                            SizedBox(height: 5.0,),
                            Text(
                              "Make an appointment",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                color: isClinicVisit?Colors.white:Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          if(isClinicVisit){
                            isClinicVisit = false;
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: isClinicVisit?Colors.white:Palette.mainColor.withOpacity(0.75),
                          boxShadow: [
                            BoxShadow(
                              color: Palette.textColorD,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isClinicVisit?Palette.greyLight:Colors.white
                              ),
                              child: Icon(
                                Icons.home,
                                color: Palette.mainColor.withOpacity(0.75),
                                size: 30.0,
                              ),
                            ),
                            SizedBox(height: 25.0,),
                            Text(
                              "Home visit",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: isClinicVisit?Colors.black:Colors.white,
                              ),
                            ),
                            SizedBox(height: 5.0,),
                            Text(
                              "Call the doctor home",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                color: isClinicVisit?Colors.grey:Colors.white,
                              ),
                            ),
                          ],
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
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What are your symptoms?",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Container(
                    height: 40.0,
                    child: AnimatedList(
                      initialItemCount: symptoms.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, int index, animation){
                        return Container(
                          margin: EdgeInsets.only(right: 5.0),
                          padding: EdgeInsets.symmetric(horizontal: 20.0,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Palette.greyLight1,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                symptoms[index].toString(),
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  Text(
                    "Popular Doctors",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0),
              child: doctorsList.isNotEmpty?GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 0.85,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 2.0,
                children: List.generate(
                  doctorsList.length , (index) {
                    Doctor doctor = doctorsList[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: DoctorDetails(doctor: doctor,)));
                      },
                      child: Container(
                        margin: index.isEven?EdgeInsets.only(left: 5.0, bottom: 10.0):EdgeInsets.only(bottom: 10.0, right: 5.0),
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Palette.textColorD,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60.0),
                                  child: Image.asset(
                                    "assets/images/profile.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0,),
                            Text(
                              '${doctor.work!.title! + " " + doctor.user!.fullname!}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Palette.greyText,
                              ),
                            ),
                            SizedBox(height: 5.0,),
                            Text(
                              '${doctor.work!.field!}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Palette.greyText1,
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ):SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
