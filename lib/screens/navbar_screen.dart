import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:medical_app/DataHandler/appdata.dart';
import 'package:medical_app/Models/tab_item.dart';
import 'package:medical_app/Models/user.dart';
import 'package:medical_app/assistants/assistant_methods.dart';
import 'package:medical_app/config/config.dart';
import 'package:medical_app/config/palette.dart';
import 'package:medical_app/screens/screens.dart';
import 'package:medical_app/sharedWidgets/widgets.dart';
import 'package:provider/provider.dart';

class NavBarScreen extends StatefulWidget {
  static const String idScreen = "NavScreen";
  final bool isNavigate;
  final int navigateIndex;
  const NavBarScreen({
    Key? key,
    this.isNavigate = false,
    this.navigateIndex = 0
  }) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {

  final List<Widget> _screens = [
    HomeScreen(),
    MessagesScreen(),
    ScheduleScreen(),
    SettingsScreen(),
  ];

  List<TabItem> _icons = [
    TabItem(MdiIcons.home, "Home"),
    TabItem(FontAwesomeIcons.message, "Messages"),
    TabItem(MdiIcons.calendar, "Schedule"),
    TabItem(MdiIcons.cog, "Settings"),
  ];

  int _selectedIndex = 0;

  @override
  void didUpdateWidget(covariant NavBarScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsNavigate();
    getData();
  }

  void checkIsNavigate(){
    if(widget.isNavigate){
      setState(() {
        _selectedIndex = widget.navigateIndex;
      });
    }
  }

  void getData(){
    getUserData();
    getWorkData();
    getDoctors();
    getUserBookings();
  }

  getUserData() async{
    Future.delayed(Duration.zero,()
    async {
      AssistantMethods.getUserData(context, await getUserId());
    });
  }

  getUserBookings() async{
    Future.delayed(Duration.zero,()
    async {
      AssistantMethods.getUserBookings(context, await getUserId());
    });
  }

  getWorkData() async{
    Future.delayed(Duration.zero,()
    async {
      AssistantMethods.getDoctorData(context, await getUserId());
    });
  }

  getDoctors() async{
    Future.delayed(Duration.zero,()
    async {
      AssistantMethods.getAllDoctors(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _icons.length,
        child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Palette.greyBorder,
                  width: 1.0,
                )
              )
            ),
            child: CustomTabBar(
              icons: _icons,
              selectedIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
            ),
          ),
        ),
    );
  }
}
