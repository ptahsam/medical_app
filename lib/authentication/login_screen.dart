import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:medical_app/assistants/assistant_methods.dart';
import 'package:medical_app/authentication/authentication.dart';
import 'package:medical_app/config/palette.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController identifier = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoggingIn = false;
  String responseMessage = "";

  bool txtPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainColor.withOpacity(0.45),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's Sign In",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 35.0,
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                "Welcome Back, \nYou've been missed!",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Palette.textColor4,
                  fontWeight: FontWeight.w400,
                  fontSize: 30.0,
                ),
              ),
              SizedBox(height: 20.0,),
              responseMessage != ""?Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: Text(
                    responseMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ):SizedBox(height: 10.0,),
              TextField(
                controller: identifier,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "Phone number or email",
                  hintStyle: TextStyle(
                    color: Palette.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                  suffixIcon: Icon(
                    FontAwesomeIcons.user,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: password,
                obscureText: txtPassword,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: Palette.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                  suffixIcon: InkWell(
                    onTap: (){
                      setState(() {
                        txtPassword = !txtPassword;
                      });
                    },
                    child: Icon(
                      txtPassword?Icons.lock_outline:MdiIcons.lockOffOutline,
                      color: Colors.black,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  "Reset password?",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Palette.mainColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 25.0,),
              InkWell(
                onTap: () async{
                  if(identifier.text.isNotEmpty && password.text.isNotEmpty){
                    setState(() {
                      isLoggingIn = true;
                    });
                    String response = await AssistantMethods.loginUser(context, identifier.text, password.text);
                    if(response == "NOT_REGISTERED"){
                      setState(() {
                        responseMessage = "No account found for the details. Signup first then Login.";
                        isLoggingIn = false;
                        identifier.clear();
                        password.clear();
                      });
                    }else if(response == "PASSWORD_NOT_MATCHED"){
                      setState(() {
                        responseMessage = "Incorrect Password. Enter correct password";
                        isLoggingIn = false;
                        password.clear();
                      });
                    }else if(response == "LOGGED_IN"){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("You have logged in."),
                      ));
                      Navigator.pop(context);
                    }else{
                      setState(() {
                        isLoggingIn = false;
                        responseMessage = "An error occurred. Please try again later.";
                      });
                    }
                  }else{
                    setState(() {
                      isLoggingIn = false;
                      responseMessage = "Enter all fields";
                    });
                  }
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
                      "${isLoggingIn?"Signing in. Please wait ...!":"Sign In"}",
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
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet?",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context, PageTransition(child: RegisterScreen(), type: PageTransitionType.rightToLeft));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Palette.mainColor,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  children: [
                    Text(
                      "By logging in, you agree to our",
                      style: TextStyle(
                        color: Palette.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Terms & conditions",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            decoration: TextDecoration.underline
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        Text(
                          "&",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        Text(
                          "Privacy policy",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            decoration: TextDecoration.underline
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
