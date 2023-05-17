// ignore_for_file: use_build_context_synchronously

import 'package:codeware_ltd_task/data/model/request/create_repo.dart';
import 'package:codeware_ltd_task/utill/color_resources.dart';
import 'package:codeware_ltd_task/utill/style/lato_styles.dart';
import 'package:codeware_ltd_task/view/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  final CreateRepo _createRepo = CreateRepo();
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  bool _isLoading = false;

  Future<void> _createUser() async{
    final String name = nameController.text.trim();
    final String job = jobController.text.trim();

    if(name.isNotEmpty && job.isNotEmpty){
      setState(() {
        _isLoading = true;
      });
      try{
        final Map<String, dynamic> apiResponse = await _createRepo.createUser(name, job);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen(name: name, job: job,)));
        setState(() {
          _isLoading = false;
        });
      } catch(error){
        setState(() {
          _isLoading = false;
        });
      }
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
          Text("Create", style: latoBold24.copyWith(color: ColorResources.black, fontSize: 30),),
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
                _isLoading ? null : _createUser();
              },
              child: Container(
                height: 50,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorResources.primaryColor,
                ),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: ColorResources.white,))
                    : Center(child: Text("Create", style: latoBold18.copyWith(color: ColorResources.white),),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
