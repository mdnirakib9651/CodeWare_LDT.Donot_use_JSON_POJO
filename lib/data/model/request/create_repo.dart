import 'dart:convert';
import 'package:codeware_ltd_task/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class CreateRepo{

  Future<Map<String, dynamic>> createUser(String name, String job) async{
    final Map<String, dynamic> userBody = {
      'name': name,
      'job': job,
    };
    final apiResponse = await http.post(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.createUrl}'),
      body: json.encode(userBody),
      headers:
      {
        'Content-Type':
        'application/json'
      },
    );
    if(apiResponse.statusCode == 201){
      return json.decode(apiResponse.body);
    } else{
      throw Exception("Crate User Failed");
    }
  }
}