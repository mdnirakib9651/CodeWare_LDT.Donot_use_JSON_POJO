
import 'package:codeware_ltd_task/utill/color_resources.dart';
import 'package:codeware_ltd_task/utill/style/lato_styles.dart';
import 'package:codeware_ltd_task/view/basewidget/deshboard_widget.dart';
import 'package:codeware_ltd_task/view/screen/create_user_screen/create_screen.dart';
import 'package:codeware_ltd_task/view/screen/user_list/user_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  bool doctorClick = true;

  static const List<Widget> _deshBoardBottomScreen = <Widget>[
    CreateScreen(),
    UserList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorResources.backGroundColor,
        title: Text("CodeWare LTD.", style: latoBold24.copyWith(color: ColorResources.black),),
      ),
      body: _deshBoardBottomScreen.elementAt(selectedIndex),
      bottomNavigationBar: DeshBoardWidget(onPress: _onItemTapped,),
    );
  }
}
