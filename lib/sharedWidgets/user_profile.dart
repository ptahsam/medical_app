import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/config/palette.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  List<String> statusList = [
    'Away',
    'At Work',
    'On Vacation',
    'Available'
  ];

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.black,
              ),
            ),
            title: Text(
              "My Profile",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              Icon(
                Icons.more_vert_outlined,
                size: 28.0,
                color: Colors.black,
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 40, left: 12.0, right: 12.0,),
            sliver: SliverToBoxAdapter(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.orange1.withOpacity(0.4),
                  ),
                ),
                title: Text(
                  "Peter Samuel",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(
                  "Joined on May",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Palette.textColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal
                  ),
                ),
                trailing: Icon(
                  Icons.edit,
                  size: 28.0,
                  color: Palette.textColorD,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                "My Status",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Palette.textColorD,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 40.0,
                child: AnimatedList(
                  key: listKey,
                  initialItemCount: statusList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, int index, animation){
                    return Container(
                      margin: EdgeInsets.only(right: 5.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: index == 0?Palette.black1:index == 1?Palette.lightGreen:index == 2?Palette.lightOrange:Colors.redAccent.withOpacity(0.2),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                            statusList[index].toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                "My Details",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Palette.textColorD,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Palette.green1
                      ),
                      child: Icon(
                        FontAwesomeIcons.user,
                        size: 28.0,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Personal Details",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 28.0,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.orange1
                      ),
                      child: Icon(
                        FontAwesomeIcons.shield,
                        size: 28.0,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Login & Security",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 28.0,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Palette.blue1,
                      ),
                      child: Icon(
                        FontAwesomeIcons.creditCard,
                        size: 28.0,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Payments and checkout",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 28.0,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.grey1,
                      ),
                      child: Icon(
                        FontAwesomeIcons.clockRotateLeft,
                        size: 28.0,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "History",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 28.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                "My Account",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Palette.textColorD,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Switch to another account",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Palette.blue1,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Log Out",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Palette.orange1,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
