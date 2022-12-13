import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/DataHandler/appdata.dart';
import 'package:medical_app/Models/user.dart';
import 'package:medical_app/Models/work.dart';
import 'package:medical_app/assistants/assistant_methods.dart';
import 'package:medical_app/config/palette.dart';
import 'package:provider/provider.dart';

class WorkProfile extends StatefulWidget {
  const WorkProfile({Key? key}) : super(key: key);

  @override
  State<WorkProfile> createState() => _WorkProfileState();
}

class _WorkProfileState extends State<WorkProfile> {

  bool isEdit = false;
  String field = "Physician";
  String title = "Sir";
  String type = "Full-time";

  TextEditingController consultationEditingController = TextEditingController();
  TextEditingController educationEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController facilitynameEditingController = TextEditingController();
  TextEditingController locationEditingController = TextEditingController();

  List<String> doctorCategories = [
    "Physician",
    "Psychiatrist",
    "Obstetrician",
    "Gynecologist",
    "Neurologist",
    "Radiologist",
    "Anesthesiologist",
    "Pediatrician",
    "Cardiologist",
  ];

  List<String> titlesList = [
    "Sir",
    "Mr",
    "Ms",
    "Miss",
    "Dr",
    "Professor",
  ];

  List<String> typeList = [
    "Full-time",
    "Part-time",
    "Freelance",
  ];

  @override
  Widget build(BuildContext context) {
    Work work  = Provider.of<AppData>(context).work!;
    User user = Provider.of<AppData>(context).user!;
    return Scaffold(
      backgroundColor: Colors.grey[200]!,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
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
              "Work Profile",
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
                    String jobtitle = title;
                    String fieldname = field;
                    String worktype = type;
                    String education = educationEditingController.text.isNotEmpty?educationEditingController.text:work.education!;
                    String description = descriptionEditingController.text.isNotEmpty?descriptionEditingController.text:work.description!;
                    String facilityname = facilitynameEditingController.text.isNotEmpty?facilitynameEditingController.text:work.facility_name!;
                    String location = locationEditingController.text.isNotEmpty?locationEditingController.text:work.location!;
                    String consultation = consultationEditingController.text.isNotEmpty?consultationEditingController.text:work.consultation_fee!;

                    var response = await AssistantMethods.saveDoctorDetails(context, user.id.toString(), jobtitle, fieldname, worktype, education, description, facilityname, location, consultation);

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
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              padding: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0, top: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      margin: EdgeInsets.only(right: 12.0),
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/profile.jpg",
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      "${user.fullname!=""?user.fullname:"No usename"}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${user.email!=""?user.email:"No email address"}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                        color: Palette.textLight,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isEdit = !isEdit;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 80.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: isEdit?Palette.mainColor:Colors.white,
                        border: Border.all(
                          width: 1.0,
                          color: Palette.mainColor,
                        ),
                      ),
                      child: Text(
                        "Edit Details",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: isEdit?Colors.white:Palette.mainColor,
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
              padding: EdgeInsets.only(left: 12.0, right: 12.0,),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.work,
                      color: Palette.textColor,
                    ),
                    title: Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.textColor,
                      ),
                    ),
                    subtitle: isEdit?DropdownButton(
                      hint: const Text(
                        "Select title",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Palette.textColor,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      isExpanded: true,
                      value: title,
                      //value: categories[0],
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items:titlesList.map((String items) {
                        return DropdownMenuItem(
                            value: items,
                            child: Row(
                              children: [
                                Text(items,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Palette.textColor,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            )
                        );
                      }
                      ).toList(),

                      onChanged: (newValue){
                        setState(() {
                          title = newValue!.toString();
                        });
                      },
                    ):Text(
                      "${work.title!=""?work.title:"No title"}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Palette.textColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Palette.textLight,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.work_outline_outlined,
                      color: Palette.textColor,
                    ),
                    title: Text(
                      "Professional field",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.textColor,
                      ),
                    ),
                    subtitle: isEdit?DropdownButton(
                      hint: const Text(
                        "Select field",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Palette.textColor,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      isExpanded: true,
                      value: field,
                      //value: categories[0],
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items:doctorCategories.map((String items) {
                        return DropdownMenuItem(
                            value: items,
                            child: Row(
                              children: [
                                Text(items,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Palette.textColor,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            )
                        );
                      }
                      ).toList(),

                      onChanged: (newValue){
                        setState(() {
                          field = newValue!.toString();
                        });
                      },
                    ):Text(
                        "${work.field!=""?work.field:"No profession"}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Palette.textColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Palette.textLight,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      FontAwesomeIcons.info,
                      color: Palette.textColor,
                    ),
                    title: Text(
                      "Employment Status",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.textColor,
                      ),
                    ),
                    subtitle: isEdit?DropdownButton(
                      hint: const Text(
                        "Select employment status",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Palette.textColor,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      isExpanded: true,
                      value: type,
                      //value: categories[0],
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items:typeList.map((String items) {
                        return DropdownMenuItem(
                            value: items,
                            child: Row(
                              children: [
                                Text(items,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Palette.textColor,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            )
                        );
                      }
                      ).toList(),

                      onChanged: (newValue){
                        setState(() {
                          type = newValue!.toString();
                        });
                      },
                    ):Text(
                      "${work.work_type!=""?work.work_type:"No employment status"}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Palette.textColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Palette.textLight,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      FontAwesomeIcons.graduationCap,
                      color: Palette.textColor,
                    ),
                    title: Text(
                      "Education",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.textColor,
                      ),
                    ),
                    subtitle: isEdit?TextField(
                      controller: educationEditingController,
                      decoration: InputDecoration(
                        hintText: "E.g Master of Clinical Medicine",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Palette.textColor,
                        ),
                      ),
                    ):Text(
                      "${work.education!=""?work.education:"No education"}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Palette.textColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Palette.textLight,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      FontAwesomeIcons.hospital,
                      color: Palette.textColor,
                    ),
                    title: Text(
                      "Facility name",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.textColor,
                      ),
                    ),
                    subtitle: isEdit?TextField(
                      controller: facilitynameEditingController,
                      decoration: InputDecoration(
                        hintText: "E.g Lotus Medical Center",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Palette.textColor,
                        ),
                      ),
                    ):Text(
                      "${work.facility_name!=""?work.facility_name:"No facility name"}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Palette.textColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Palette.textLight,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.location_pin,
                      color: Palette.textColor,
                    ),
                    title: Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.textColor,
                      ),
                    ),
                    subtitle: isEdit?TextField(
                      controller: locationEditingController,
                      decoration: InputDecoration(
                        hintText: "E.g 3516 W. Gray St. Ultica, New York.",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Palette.textColor,
                        ),
                      ),
                    ):Text(
                      "${work.location!=""?work.location:"No location"}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Palette.textColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Palette.textLight,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.monetization_on_sharp,
                      color: Palette.textColor,
                    ),
                    title: Text(
                      "Consultation fee",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.textColor,
                      ),
                    ),
                    subtitle: isEdit?TextField(
                      controller: consultationEditingController,
                      decoration: InputDecoration(
                        prefixText: "Hourly/KES .",
                        prefixStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Palette.textColor,
                        ),
                        hintText: "E.g 200",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Palette.textColor,
                        ),
                      ),
                    ):Text(
                      "${work.consultation_fee!=""?work.consultation_fee:"No fee"}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Palette.textColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Palette.textLight,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.info,
                      color: Palette.textColor,
                    ),
                    title: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Palette.textColor,
                      ),
                    ),
                    subtitle: isEdit?TextField(
                      controller: descriptionEditingController,
                      minLines: 2,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Type a short description about yourself e.g what you do, your specialisation, your qualified",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Palette.textColor,
                        ),
                      ),
                    ):Text(
                      "${work.description!=""?work.description:"No description"}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Palette.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
