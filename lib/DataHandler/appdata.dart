import 'package:flutter/foundation.dart';
import 'package:medical_app/Models/user.dart';

class AppData extends ChangeNotifier
{
  User? user;

  void updateUser(User loggedUser, bool hasData)
  {
    if(hasData){
      user = loggedUser;
    }else{
      user = null;
    }
    notifyListeners();
  }
}