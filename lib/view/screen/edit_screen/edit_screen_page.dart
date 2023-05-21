// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:codeware_ltd_task/data/model/response/user_list_model.dart';
import 'package:codeware_ltd_task/utill/color_resources.dart';
import 'package:codeware_ltd_task/utill/style/lato_styles.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final UserListModel? user;
  final Function(UserListModel)? onUpdate;
  const EditScreen({Key? key,  this.user, this.onUpdate}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  final bool _isLoading = false;

  void _updateUser() {
    UserListModel updatedUser = UserListModel(
      id: widget.user!.id,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      avatar: 'avatar',
    );

    widget.onUpdate!(updatedUser);

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.user!.firstName);
    lastNameController = TextEditingController(text: widget.user!.lastName);
    emailController = TextEditingController(text: widget.user!.email);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
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
              controller: firstNameController,
              decoration: InputDecoration(
                  hintText: "First Name",
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
              controller: lastNameController,
              decoration: InputDecoration(
                  hintText: "Last Name",
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
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "User Email",
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
                _isLoading ? null : _updateUser();
              },
              child: Container(
                height: 50,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorResources.primaryColor,
                ),
                child: _isLoading ? const Center(child: CircularProgressIndicator(),) :
                Center(child: Text("Update", style: latoBold18.copyWith(color: ColorResources.white),),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
