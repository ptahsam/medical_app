import 'package:flutter/material.dart';
import 'package:medical_app/DataHandler/appdata.dart';
import 'package:medical_app/Models/doctor_booking.dart';
import 'package:medical_app/assistants/assistant_methods.dart';
import 'package:medical_app/config/config.dart';
import 'package:medical_app/config/palette.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  int _active = 1;

  @override
  Widget build(BuildContext context) {
    List<DoctorBooking> bookingList = Provider.of<AppData>(context).doctorBookingList!=null?Provider.of<AppData>(context).doctorBookingList!:[];
    List<DoctorBooking> doctorBookingList = arrangeDoctorBooking(_active, bookingList);
    updateCompletedBookings(doctorBookingList);
    return Scaffold(
      backgroundColor: Colors.white70,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: _active == 1?false:true,
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
            child: _active == 1?Container(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
              child: Text(
                "Nearest visit",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ):SizedBox.shrink(),
          ),
          SliverToBoxAdapter(
            child: _active == 1?Container(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
              child: doctorBookingList.isNotEmpty?ScheduleCard(active: _active, doctorBooking: doctorBookingList.first,):SizedBox(),
            ):SizedBox.shrink(),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
              child: Text(
                "${_active == 1 && doctorBookingList.length - 1 > 0?"Future visits":_active == 2?"Completed visits":_active == 3?"Cancelled visits":""}",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
            sliver: _active == 1?SliverAnimatedList(
              initialItemCount: doctorBookingList.length - 1 > 0?doctorBookingList.length - 1:0,
              itemBuilder: (_, int index, animation){
                DoctorBooking doctorBooking = doctorBookingList[index + 1];
                return Column(
                  children: [
                    ScheduleCard(active: _active, doctorBooking: doctorBooking,),
                    SizedBox(height: 10.0,),
                  ],
                );
              },
            ):doctorBookingList.isNotEmpty?SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.zero,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: doctorBookingList.length,
                  itemBuilder: (_, int index){
                    DoctorBooking doctorBooking = doctorBookingList[index];
                    return Column(
                      children: [
                        ScheduleCard(active: _active, doctorBooking: doctorBooking,),
                        SizedBox(height: 10.0,),
                      ],
                    );
                  },
                ),
              ),
            ):SliverToBoxAdapter(
              child: Text(doctorBookingList.length.toString()),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateCompletedBookings(List<DoctorBooking> doctorBookingList) async {
    if(doctorBookingList.isNotEmpty){
      for(var i = 0; i < doctorBookingList.length; i++){
        DoctorBooking doctorBooking = doctorBookingList[i];
        if(int.parse(doctorBooking.booking!.scheduledate!) < int.parse(DateTime.now().millisecondsSinceEpoch.toString())){
          String response = await AssistantMethods.saveScheduleDetails(context, doctorBooking.booking!.id!.toString(), await getUserId(),
          doctorBooking.doctor!.user!.id!.toString(), doctorBooking.booking!.scheduledate!, doctorBooking.booking!.schedule_start_time!,
          doctorBooking.booking!.schedule_end_time!, "completed", doctorBooking.booking!.notes!);
          if(response == "SUCCESS"){
            await AssistantMethods.getUserBookings(context, await getUserId());
          }
        }
      }
    }
  }

}

class ScheduleCard extends StatefulWidget {
  final int active;
  final DoctorBooking doctorBooking;
  const ScheduleCard({
    Key? key,
    required this.active,
    required this.doctorBooking
  }) : super(key: key);

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
              '${widget.doctorBooking.doctor!.work!.title!}. ${widget.doctorBooking.doctor!.user!.fullname!}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Palette.textColor,
              ),
            ),
            subtitle: Text(
              widget.doctorBooking.doctor!.work!.field!,
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
                    convertToFullDate(int.parse(widget.doctorBooking.booking!.scheduledate!)),
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
                    widget.doctorBooking.booking!.schedule_start_time!,
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
                    color: widget.doctorBooking.booking!.status == "booked"?
                    Palette.orange1:widget.doctorBooking.booking!.status == "confirmed"?
                    Palette.mainColor:widget.doctorBooking.booking!.status == "cancelled"?
                    Colors.red:Palette.primaryColor,
                  ),
                  SizedBox(width: 3.0,),
                  Text(
                    toBeginningOfSentenceCase(widget.doctorBooking.booking!.status!)!,
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
                child: widget.active == 2 || widget.active == 3?SizedBox.shrink():InkWell(
                  onTap: () async{
                    String response = await AssistantMethods.saveScheduleDetails(context, widget.doctorBooking.booking!.id!.toString(), await getUserId(),
                        widget.doctorBooking.doctor!.user!.id!.toString(), widget.doctorBooking.booking!.scheduledate!, widget.doctorBooking.booking!.schedule_start_time!,
                        widget.doctorBooking.booking!.schedule_end_time!, "cancelled", widget.doctorBooking.booking!.notes!);
                    if(response == "SUCCESS"){
                      await AssistantMethods.getUserBookings(context, await getUserId());
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(response),
                    ));
                  },
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
              ),
              SizedBox(width: 30.0,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: widget.doctorBooking.booking!.status == "booked"?
                    Palette.orange1:widget.doctorBooking.booking!.status == "confirmed"?
                    Palette.mainColor:widget.doctorBooking.booking!.status == "cancelled"?
                    Colors.red:Palette.primaryColor,
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

