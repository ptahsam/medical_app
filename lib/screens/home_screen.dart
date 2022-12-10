import 'package:flutter/material.dart';
import 'package:medical_app/DataHandler/appdata.dart';
import 'package:medical_app/Models/user.dart';
import 'package:medical_app/sharedWidgets/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AppData>(context).user!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leadingWidth: 0,
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
              user.photo != null?InkWell(
                onTap: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: UserProfile()));
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: ProfileAvatar(imageUrl: user.photo!, hasBorder: true, radius: 28.0, borderWidth: 27.0,)
                ),
              ):Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 28.0,
                    backgroundColor: Colors.grey[200],
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
