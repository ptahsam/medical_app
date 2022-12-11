import 'package:flutter/material.dart';
import 'package:medical_app/config/palette.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  int _active = 1;

  @override
  Widget build(BuildContext context) {
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
              "Schedule",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 50.0,
              margin: EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Palette.greyLight,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          _active = 1;
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: _active == 1?Palette.mainColor:Palette.greyLight,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              "Upcoming",
                              style: TextStyle(
                                color: _active == 1?Colors.white:Palette.textColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _active == 3?Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
                    width: 2.0,
                    color: Palette.textColor,
                  ):SizedBox(),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          _active = 2;
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: _active == 2?Palette.mainColor:Palette.greyLight,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              "Completed",
                              style: TextStyle(
                                color: _active == 2?Colors.white:Palette.textColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _active == 1?Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    width: 2.0,
                    color: Palette.textColor,
                  ):SizedBox(),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          _active = 3;
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: _active == 3?Palette.mainColor:Palette.greyLight,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              "Canceled",
                              style: TextStyle(
                                color: _active == 3?Colors.white:Palette.textColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
              child: Text(
                "Nearest visit",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
              child: ScheduleCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
              child: Text(
                "Future visits",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
            sliver: SliverAnimatedList(
              initialItemCount: 5,
              itemBuilder: (_, int index, animation){
                return Column(
                  children: [
                    ScheduleCard(),
                    SizedBox(height: 10.0,),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({Key? key}) : super(key: key);

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFe8e8e8),
            blurRadius: 5.0,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Color(0xFFe8e8e8),
            offset: Offset(1, 0),
          ),
          BoxShadow(
            color: Color(0xFFe8e8e8),
            offset: Offset(1, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Dr. Phil Molly",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Palette.textColor,
              ),
            ),
            subtitle: Text(
              "Physician",
              style: TextStyle(
                color: Palette.textLight,
                fontSize: 16.0,
                fontWeight: FontWeight.normal
              ),
            ),
            trailing: Container(
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            height: 1.0,
            decoration: BoxDecoration(
              color: Palette.textLight.withOpacity(0.6),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 18.0,
                    color: Palette.textColor,
                  ),
                  SizedBox(width: 3.0,),
                  Text(
                    "12/03/2021",
                    style: TextStyle(
                      color: Palette.textColor,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: 18.0,
                    color: Palette.textColor,
                  ),
                  SizedBox(width: 3.0,),
                  Text(
                    "10.30 AM",
                    style: TextStyle(
                      color: Palette.textColor,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 18.0,
                    color: Palette.primaryColor,
                  ),
                  SizedBox(width: 3.0,),
                  Text(
                    "Confirmed",
                    style: TextStyle(
                      color: Palette.textColor,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 25.0,),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300]!.withOpacity(0.75),
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Palette.textColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 30.0,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Palette.mainColor,
                  ),
                  child: Center(
                    child: Text(
                      "Reschedule",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

