import 'dart:convert';
import 'package:codeware_ltd_task/utill/app_constants.dart';
import 'package:codeware_ltd_task/utill/color_resources.dart';
import 'package:codeware_ltd_task/utill/style/lato_styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Map<String, dynamic> userData = {};

  Future<Map<String, dynamic>> fetchUserData() async{
    final apiResponse = await http.get(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.singleUserUrl}')
    );
    if(apiResponse.statusCode == 200){
      final jsonData = jsonDecode(apiResponse.body);
      final Map<String, dynamic> userData = jsonData['data'];
      return userData;
    } else{
      return {};
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData().then((data){
      setState(() {
        userData = data;
      });
    }).catchError((error){
      debugPrint("Error -------->>>>>>> $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUserData(),
        builder: (context, snapShot){
          if(snapShot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapShot.hasError){
            return Center(child: Text("Error ${snapShot.error}"),);
          } else if(snapShot.hasData && snapShot.data!.isNotEmpty){
            final userData = snapShot.data!;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorResources.backGroundColor,
                      ),
                      child: const Center(child: Icon(Icons.person, size: 40, color: ColorResources.grey,),),
                    ),
                    const SizedBox(height: 20,),
                    Text("${userData['first_name']} ${userData['last_name']}", style: latoBold24.copyWith(color: ColorResources.black),),
                    Text("${userData['email']}", style: latoBold18.copyWith(color: ColorResources.black),),
                  ],
                ),
              ],
            );
          } else{
            return const Center(child: Text("No Data avilable"),);
          }
        },
      ),
    );
  }
}
