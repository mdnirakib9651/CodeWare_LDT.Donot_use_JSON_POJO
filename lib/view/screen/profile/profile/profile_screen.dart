import 'package:codeware_ltd_task/utill/color_resources.dart';
import 'package:codeware_ltd_task/utill/style/lato_styles.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String? name;
  final String? job;
  const ProfileScreen({Key? key, this.name, this.job}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        elevation: 0,
      ),
      body: Row(
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
              Text("${widget.name}", style: latoBold24.copyWith(color: ColorResources.black),),
              Text("${widget.job}", style: latoBold18.copyWith(color: ColorResources.black),),
            ],
          ),
        ],
      ),
    );
  }
}
