// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'dart:convert';
import 'package:codeware_ltd_task/data/model/response/user_list_model.dart';
import 'package:codeware_ltd_task/utill/app_constants.dart';
import 'package:codeware_ltd_task/utill/color_resources.dart';
import 'package:codeware_ltd_task/utill/style/lato_styles.dart';
import 'package:codeware_ltd_task/view/screen/edit_screen/edit_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserList extends StatefulWidget {
  const UserList({Key? key,}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserListModel> users = [];
  int page = 1;
  int totalPages = 1;

  Future<void> UserListData() async{
    final apiResponse = await http.get(
      Uri.parse('${AppConstants.baseUrl}${AppConstants.userListUrl}$page'),
    );
    if(apiResponse.statusCode == 200){
      final jsonData = json.decode(apiResponse.body);
      debugPrint(apiResponse.body);
      final List<dynamic> userList = jsonData['data'];
      final List<UserListModel> fetchedUsers = userList.map((user) => UserListModel.fromJson(user)).toList();
      setState(() {
        users.addAll(fetchedUsers);
        totalPages = jsonData['total_pages'];
      });
    } else{
      throw Exception('Failed ');
    }
  }

  Future<void> _deleteUser(int id) async{
    final apiResponse = await http.delete(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.deleteUrl}$id')
    );
    if(apiResponse.statusCode == 204){
      setState(() {
        users.removeWhere((user) => user.id == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User deleted successfully")));
    } else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to delete user")));
    }
  }

  void _updateUserData(UserListModel updatedUser) {
    setState(() {
      final index = users.indexWhere((user) => user.id == updatedUser.id);
      if (index != -1) {
        users[index] = updatedUser;
      }
    });
  }


  Future<void> loadUsers() async{
    if(page < totalPages){
      page++;
      await UserListData();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserListData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorResources.backGroundColor,
      body: RefreshIndicator(
        onRefresh: (){
          return loadUsers();
        },
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index){
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Container(
                  height: 120,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorResources.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                            const SizedBox(width: 20,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${user.firstName} ${user.lastName}", style: latoBold24.copyWith(color: ColorResources.black),),
                                Text(user.email, style: latoRegular18.copyWith(color: ColorResources.black),),
                              ],
                            )
                          ],
                        ),
                        InkWell(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      actions: [
                                        Container(
                                          height: 130,
                                          width: size.width,
                                          color: ColorResources.white,
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 15,),
                                              Text("Do you want to edit or delete?", style: latoRegular.copyWith(color: ColorResources.black),),
                                              const SizedBox(height: 40,),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(user: user, onUpdate: _updateUserData,)));
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: size.width / 3,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50),
                                                          color: ColorResources.searchBackGroundColor,
                                                        ),
                                                        child: Center(child: Text("Edit", style: latoRegular.copyWith(color: ColorResources.black),),),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        _deleteUser(user.id);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: size.width / 3,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50),
                                                          color: ColorResources.primaryColor,
                                                        ),
                                                        child: Center(child: Text("Delete", style: latoRegular.copyWith(color: ColorResources.white),),),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Icon(Icons.more_vert, color: ColorResources.grey,))
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
