
import 'package:medical_app/DataHandler/appdata.dart';
import 'package:medical_app/Models/user.dart';
import 'package:medical_app/assistants/request_assistant.dart';
import 'package:provider/provider.dart';

class AssistantMethods
{
  static Future<String> loginUser(context, String identifier, String password) async{
    String data = "";
    var params = {
      'loginUser': '1',
      'identifier': '${identifier}',
      'password': '${password}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response.toString() != "failed" && response.toString() != "NOT_REGISTERED" && response.toString() != "PASSWORD_NOT_MATCHED"){

      User user = User.fromJson(response);

      Provider.of<AppData>(context, listen: false).updateUser(user, true);
      data = "LOGGED_IN";
    }else{
      data = response.toString();
    }
    return data;
  }

  static Future<String> registerUser(context, String identifier, String password, String role) async{
    String data = "";
    var params = {
      'registerUser': '1',
      'identifier': '${identifier}',
      'password': '${password}',
      'role': '${role}',
    };

    var response = await RequestAssistant.getRequest(params);

    if(response != "failed"){
      data = response.toString();
    }else{
      data = "failed";
    }
    return data;
  }
}