import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:medical_app/assistants/assistant_methods.dart';
import 'package:medical_app/authentication/authentication.dart';
import 'package:medical_app/config/palette.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String userRole = "Patient";
  List<String> roleItems = ["Patient", "Doctor"];

  TextEditingController identifier = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isRegistering = false;
  String responseMessage = "";

  bool txtPassword = true;
  bool txtConfirmPassword = true;

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
                "Let's Sign Up",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 35.0,
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                "Create account, \nTo begin your journey",
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
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(

                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: const Text(
                      "Select role",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    isExpanded: true,
                    value: userRole,
                    //value: categories[0],
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items:roleItems.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Row(
                            children: [
                              Text(items,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          )
                      );
                    }
                    ).toList(),

                    onChanged: (newValue){
                      setState(() {
                        userRole = newValue!.toString();
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
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
              SizedBox(height: 20.0,),
              TextField(
                controller: confirmPassword,
                obscureText: txtConfirmPassword,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "Confirm password",
                  hintStyle: TextStyle(
                    color: Palette.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                  suffixIcon: InkWell(
                    onTap: (){
                      setState(() {
                        txtConfirmPassword = !txtConfirmPassword;
                      });
                    },
                    child: Icon(
                      txtConfirmPassword?Icons.lock_outline:MdiIcons.lockOffOutline,
                      color: Colors.black,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 25.0,),
              InkWell(
                onTap: () async{
                  if(identifier.text.isNotEmpty && password.text.isNotEmpty && confirmPassword.text.isNotEmpty){
                    if(password.text == confirmPassword.text){
                      setState(() {
                        isRegistering = true;
                      });
                      String role = userRole == "Patient"?"1":"2";
                      String response = await AssistantMethods.registerUser(context, identifier.text, password.text, role);
                      if(response == "USER_ALREADY_EXISTS"){
                        setState(() {
                          responseMessage = "An account with similar details already exists. Try to login";
                          isRegistering = false;
                        });
                      }else if(response == "UNKNOWN_ERROR" || response == "failed"){
                        setState(() {
                          responseMessage = "An error occurred. Please try again later.";
                          isRegistering = false;
                        });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Your account has been created successfully. You can login now."),
                        ));
                        Navigator.pop(context);
                        Navigator.push(context, PageTransition(child: LoginScreen(), type: PageTransitionType.rightToLeft));
                      }
                    }else{
                      setState(() {
                        isRegistering = false;
                        responseMessage = "Confirm password is incorrect";
                      });
                    }
                  }else{
                    setState(() {
                      isRegistering = false;
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
                      "${isRegistering?"Signing up. Please wait ...!":"Sign Up"}",
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
                      "Already have an account?",
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
                        Navigator.push(context, PageTransition(child: LoginScreen(), type: PageTransitionType.rightToLeft));
                      },
                      child: Text(
                        "Sign In",
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
                      "By signing up, you agree to our",
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
