import 'package:flutter/material.dart';
import 'package:medical_app/authentication/authentication.dart';
import 'package:medical_app/config/palette.dart';
import 'package:page_transition/page_transition.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor.withOpacity(0.45),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 70.0),
        decoration: BoxDecoration(
            color: Colors.transparent
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
              child: Image.asset(
                "assets/images/login.png",
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Medical App - Doctor Appointment Application",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Text(
                      "Medical app helps patients and doctors make appointments and communicate freely.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Palette.textColor4,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, PageTransition(child: LoginScreen(), type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Palette.mainColor.withOpacity(0.9),
                        ),
                        child: Center(
                          child: Text(
                            "Login to get Started",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, PageTransition(child: RegisterScreen(), type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          border: Border.all(
                            width: 1.0,
                            color: Palette.mainColor.withOpacity(0.9),
                          ),
                        ),

                        child: Center(
                          child: Text(
                            "Register to get Started",
                            style: TextStyle(
                                color: Palette.mainColor.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
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
      ),
    );
  }
}
