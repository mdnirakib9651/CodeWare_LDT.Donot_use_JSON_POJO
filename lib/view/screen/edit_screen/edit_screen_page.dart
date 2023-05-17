// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:codeware_ltd_task/utill/app_constants.dart';
import 'package:codeware_ltd_task/utill/color_resources.dart';
import 'package:codeware_ltd_task/utill/style/lato_styles.dart';
import 'package:codeware_ltd_task/view/screen/user_list/user_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  Future<void> updateUser() async{
    final String name = nameController.text.trim();
    final String job = jobController.text.trim();
    final apiResponse = await http.put(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.updateUrl}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'job' : job,
      })
    );
    if(apiResponse.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User List Update successfully")));
      final jsonResponse = jsonDecode(apiResponse.body);
      final update = jsonResponse['updatedAt'];
      print("User Update at: $update");
      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserList()));
    } else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to Update user")));
      print('Error: ${apiResponse.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height / 5.5,),
          Text("Edit", style: latoBold24.copyWith(color: ColorResources.black, fontSize: 30),),
          const SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "User Name",
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
              controller: jobController,
              decoration: InputDecoration(
                  hintText: "Job",
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
                updateUser();
              },
              child: Container(
                height: 50,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorResources.primaryColor,
                ),
                child: Center(child: Text("Update", style: latoBold18.copyWith(color: ColorResources.white),),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
