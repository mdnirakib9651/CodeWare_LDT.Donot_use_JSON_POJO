// ignore_for_file: camel_case_types

import 'package:codeware_ltd_task/utill/color_resources.dart';
import 'package:codeware_ltd_task/utill/style/lato_styles.dart';
import 'package:flutter/material.dart';

class DeshBoardWidget extends StatefulWidget {
  final Function(int index) onPress;
  const DeshBoardWidget({Key? key, required this.onPress}) : super(key: key);

  @override
  State<DeshBoardWidget> createState() => _DeshBoardWidgetState();
}

class _DeshBoardWidgetState extends State<DeshBoardWidget> {

  Color userCreate = ColorResources.primaryColor;
  Color userList = ColorResources.grey;
  Color userProfile = ColorResources.grey;

  int selectedIndex = 0;

  void _onBottomBarTapped(int index){
    setState(() {
      selectedIndex = index;

      if(selectedIndex == 0){
        userCreate = ColorResources.primaryColor;
        userList = ColorResources.grey;
        userProfile = ColorResources.grey;
      }
      else if(selectedIndex == 1){
        userCreate = ColorResources.grey;
        userList = ColorResources.primaryColor;
        userProfile = ColorResources.grey;
      }
      else if(selectedIndex == 2){
        userCreate = ColorResources.grey;
        userList = ColorResources.grey;
        userProfile = ColorResources.primaryColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return BottomAppBar(
      color: ColorResources.white,
      notchMargin: 7.0,
      elevation: 0.0,
      // shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  widget.onPress(0);
                  _onBottomBarTapped(0);
                },
                child: Container(
                  height: 50,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.login, color: userCreate, size: 25,),
                      const SizedBox(height: 5,),
                      Text("User Create", style: latoRegular.copyWith(color: userCreate, fontSize: 12),)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  widget.onPress(1);
                  _onBottomBarTapped(1);
                },
                child: Container(
                  height: 50,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.list, color: userList, size: 25,),
                      const SizedBox(height: 5,),
                      Text("User List", style: latoRegular.copyWith(color: userList, fontSize: 12),)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  widget.onPress(2);
                  _onBottomBarTapped(2);
                },
                child: Container(
                  height: 50,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.person, color: userProfile, size: 25,),
                      const SizedBox(height: 5,),
                      Text("Profile", style: latoRegular.copyWith(color: userProfile, fontSize: 12),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
