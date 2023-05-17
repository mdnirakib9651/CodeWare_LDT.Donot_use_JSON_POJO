// import 'dart:convert';
//
// import 'package:codeware_ltd_task/data/model/request/create_repo.dart';
// import 'package:codeware_ltd_task/data/model/response/base/api%20response/api_response.dart';
// import 'package:codeware_ltd_task/data/model/response/user_list_model.dart';
// import 'package:flutter/cupertino.dart';
//
// class AuthProvider with ChangeNotifier{
//   AuthRepo authRepo;
//
//   AuthProvider({required this.authRepo});
//
//   Future getCreate(BuildContext context, UserModel userModel) async{
//     ApiResponse apiResponse = await authRepo.create(userModel);
//     if(apiResponse.response != null && apiResponse.response!.statusCode == 200){
//       return json.decode(apiResponse.response.);
//     }
//   }
// }