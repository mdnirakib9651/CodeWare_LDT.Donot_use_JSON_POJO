// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:codeware_ltd_task/utill/app_constants.dart';
import 'package:codeware_ltd_task/utill/color_resources.dart';
import 'package:codeware_ltd_task/utill/style/lato_styles.dart';
import 'package:codeware_ltd_task/view/screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String errorMessage = '';

  Future<void> _registration() async{
    final email = emailController.text.trim();
    final password = passController.text.trim();
    final apiResponse = await http.post(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.registerUrl}'),
      body: jsonEncode({
        'email' : email,
        'password' : password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(apiResponse.statusCode == 200){
      final jsonData = jsonDecode(apiResponse.body);
      final int userId = jsonData['id'];
      final String token = jsonData['token'];

      debugPrint("User registered successfully");
      debugPrint("User Id: $userId");
      debugPrint("---------------->>>>>>>>>>>>> User Token: $token");
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Successful")));
    } else{
      final jsonData = json.decode(apiResponse.body);
      final String error = jsonData['error'];
      setState(() {
        errorMessage = 'Failed to register user. Error: $error';
      });
      debugPrint("------------->>>>>>>>>>>>>> Failed to register user. Status code: ${apiResponse.statusCode}");
      debugPrint("------------->>>>>>>>>>>>>> Failed to register user. Status code: $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Failed : $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.backGroundColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height / 5.5,),
          Text("Registration", style: latoBold24.copyWith(color: ColorResources.black, fontSize: 30),),
          const SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Email",
                  labelStyle: latoSemiBold18.copyWith(color: ColorResources.black),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: ColorResources.primaryColorShodo,
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.person, color: ColorResources.primaryColor,)
              ),
              cursorColor: ColorResources.black,
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: passController,
              decoration: InputDecoration(
                  hintText: "Password",
                  labelStyle: latoSemiBold18.copyWith(color: ColorResources.black),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none
                  ),
                  filled: true,
                  fillColor: ColorResources.primaryColorShodo,
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.work, color: ColorResources.primaryColor,)
              ),
              cursorColor: ColorResources.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: InkWell(
              onTap: (){
                _registration();
              },
              child: Container(
                height: 50,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorResources.primaryColor,
                ),
                child: Center(child: Text("Registration", style: latoBold18.copyWith(color: ColorResources.white),),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text("AllReady has been Account? ", style: latoBold16.copyWith(color: ColorResources.black),),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                        },
                        child: Text("Log IN", style: latoBold16.copyWith(color: ColorResources.primaryColor),)),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
