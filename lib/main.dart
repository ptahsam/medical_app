import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_app/DataHandler/appdata.dart';
import 'package:medical_app/authentication/authentication.dart';
import 'package:medical_app/authentication/login_screen.dart';
import 'package:medical_app/config/colorMap.dart';
import 'package:medical_app/config/config.dart';
import 'package:medical_app/screens/home_screen.dart';
import 'package:medical_app/screens/screens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String userid = "";

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    userid = await getUserId();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getUserData();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyApp oldWidget) {
    // TODO: implement didUpdateWidget
    getUserData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context){
        return AppData();
      },
      child: Consumer<AppData>(
        builder: (BuildContext context, value, Widget? child){
          return MaterialApp(
            title: 'MedicalApp',
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle.light, // 2
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primarySwatch: MaterialColor(0xFF1c4966, color),
              textTheme:
              Theme.of(context).textTheme.apply(
                //bodyColor: Colors.white, //<-- SEE HERE
                //displayColor: Colors.white, //<-- SEE HERE
              ),
            ),
            home: userid != ""?NavBarScreen():StartScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}