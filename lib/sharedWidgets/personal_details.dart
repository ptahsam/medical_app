
import 'package:flutter/material.dart';
import 'package:medical_app/DataHandler/appdata.dart';
import 'package:medical_app/Models/apiConstants.dart';
import 'package:medical_app/Models/user.dart';
import 'package:medical_app/assistants/assistant_methods.dart';
import 'package:medical_app/config/palette.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {

  bool isEdit = false;
  bool canUpdate = false;
  List<String> gender = ["Male", "Female"];
  String selectedGender = "Male";

  TextEditingController fullnameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController birthdateEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  TextEditingController zipcodeEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void textFieldChange(String value){
    if(value.isNotEmpty){
      setState(() {
        canUpdate = true;
      });
    }else{
      setState(() {
        canUpdate = false;
      });
    }
  }



  void setUserDetails(User user){
    fullnameEditingController.text = user.fullname!;
    emailEditingController.text = user.email!;
    phoneEditingController.text = user.phonenumber!;
    birthdateEditingController.text = user.birthdate!;
    addressEditingController.text = user.street_address!;
    cityEditingController.text = user.city!;
    zipcodeEditingController.text = user.zipcode!;
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AppData>(context).user!;
    setUserDetails(user);
    return Scaffold(
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
                Icons.clear,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              isEdit?Container(
                margin: EdgeInsets.only(
                  right: 12.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.primaryColor,
                  ),
                  onPressed: () async {
                    String fullname = fullnameEditingController.text.isNotEmpty?fullnameEditingController.text:user.fullname!;
                    String phonenumber = phoneEditingController.text.isNotEmpty?phoneEditingController.text:user.phonenumber!;
                    String email = emailEditingController.text.isNotEmpty?emailEditingController.text:user.email!;
                    String photo = user.photo!;
                    String birthdate = birthdateEditingController.text.isNotEmpty?birthdateEditingController.text:user.birthdate!;
                    String streetaddress = addressEditingController.text.isNotEmpty?addressEditingController.text:user.street_address!;
                    String city = cityEditingController.text.isNotEmpty?cityEditingController.text:user.city!;
                    String zipcode = zipcodeEditingController.text.isNotEmpty?zipcodeEditingController.text:user.zipcode!;

                    var response = await AssistantMethods.updateUser(context, user.id.toString(), fullname, phonenumber, email, photo, birthdate, streetaddress, city, zipcode);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(response),
                    ));
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ):SizedBox.shrink(),
            ],
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
                          isEdit = !isEdit;
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: isEdit?Palette.greyLight:Palette.black1,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                color: isEdit?Colors.black:Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isEdit = !isEdit;
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: isEdit?Palette.black1:Palette.greyLight,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                color: isEdit?Colors.white:Colors.black,
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
              padding: EdgeInsets.only(left: 12.0, top: 20.0, right: 12.0),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Palette.accentColor,
                        border: Border.all(
                          width: 2.0,
                          color: Colors.white,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: user.photo != null && user.photo != ""?InkWell(
                          onTap: (){
                            //Navigator.push(context, PageTransition(child: ViewUserPhoto(user: user,), type: PageTransitionType.rightToLeft));
                          },
                          child: Image.network(
                            user.photo!.contains("https")?user.photo!:"${ApiConstants.baseUrl}/images/profiles/${user.photo!}",
                            height: 100.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ):Image.asset(
                          "assets/images/profile.jpg",
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: InkWell(
                        onTap: (){
                          /*showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                            ),
                            context: context,
                            builder: (context) => //buildSelectSheet(),
                          );*/
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.primaryColor,
                            border: Border.all(
                              width: 2.0,
                              color: Colors.white,
                            ),
                          ),
                          child: user.photo != null && user.photo != ""?Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ):Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fullname",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Palette.textColor,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextField(
                    enabled: isEdit,
                    controller: fullnameEditingController,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Fullname",
                      hintStyle: TextStyle(
                        color: Palette.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    "Phone number",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Palette.textColor,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextField(
                    controller: phoneEditingController,
                    enabled: isEdit,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Phone number",
                      hintStyle: TextStyle(
                        color: Palette.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    "Gender",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Palette.textColor,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(),
                          ),
                          child: Row(
                            children: [
                              Radio(
                                value: "Male",
                                groupValue: "Male",
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                              Text(
                                "Male",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(),
                          ),
                          child: Row(
                            children: [
                              Radio(
                                value: "Female",
                                groupValue: "Female",
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                              Text(
                                "Female",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    "Email address",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Palette.textColor,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextField(
                    controller: emailEditingController,
                    enabled: isEdit,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Email address",
                      hintStyle: TextStyle(
                        color: Palette.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    "Date of Birth",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Palette.textColor,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextField(
                    controller: birthdateEditingController,
                    enabled: isEdit,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Date of birth",
                      hintStyle: TextStyle(
                        color: Palette.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 26.0,
                        color: Palette.textColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    "Address",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Palette.textColor,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextField(
                    controller: addressEditingController,
                    enabled: isEdit,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Address",
                      hintStyle: TextStyle(
                        color: Palette.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    "City",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Palette.textColor,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextField(
                    controller: cityEditingController,
                    enabled: isEdit,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "City",
                      hintStyle: TextStyle(
                        color: Palette.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    "Zipcode",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Palette.textColor,
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextField(
                    controller: zipcodeEditingController,
                    enabled: isEdit,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Zipcode",
                      hintStyle: TextStyle(
                        color: Palette.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
