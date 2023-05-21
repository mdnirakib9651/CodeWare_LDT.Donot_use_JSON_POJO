// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:codeware_ltd_task/utill/app_constants.dart';
import 'package:codeware_ltd_task/utill/color_resources.dart';
import 'package:codeware_ltd_task/utill/style/lato_styles.dart';
import 'package:codeware_ltd_task/view/screen/home%20page/home_page.dart';
import 'package:codeware_ltd_task/view/screen/registration_screen/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future<void> logInUser() async{
    final email = emailController.text.trim();
    final pass = passController.text.trim();

    final apiResponse = await http.post(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.logInUrl}'),
      body: json.encode({
        'email' : email,
        'password' : pass,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if(apiResponse.statusCode == 200){
      final jsonData = json.decode(apiResponse.body);
      final String token = jsonData['token'];
      print("--------------->>>>>>>>>>> Token: $token");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful")));
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else{
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Error")));
        debugPrint(" ----------------------->>>>>> Failed to logIn. Status code: ${apiResponse.statusCode}");
      });
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
          Text("Log In", style: latoBold24.copyWith(color: ColorResources.black, fontSize: 30),),
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
                      borderSide: BorderSide.none
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none
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
                // _isLoading ? null : createUser();
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                logInUser();
              },
              child: Container(
                height: 50,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorResources.primaryColor,
                ),
                child: Center(child: Text("Log In", style: latoBold18.copyWith(color: ColorResources.white),),),
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
                    Text("Create your Account? ", style: latoBold16.copyWith(color: ColorResources.black),),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));
                        },
                        child: Text("Registration", style: latoBold16.copyWith(color: ColorResources.primaryColor),)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
