import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medical_app/Models/apiConstants.dart';

class RequestAssistant
{
  static Future<dynamic> getRequest(Map params) async
  {
    var response = await http.post(Uri.parse("${ApiConstants.baseUrl}/includes/process.php"),
        body: params);
    try
    {
      if(response.statusCode == 200)
      {
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);
        return decodeData;
      }
      else
      {
        return "failed";
      }
    }
    catch(exp)
    {
      return "failed";
    }
  }
}