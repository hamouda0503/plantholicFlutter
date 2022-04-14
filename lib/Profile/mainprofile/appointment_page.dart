import 'package:flutter/material.dart';
import 'package:plantholic/Model/profileModel.dart';
import 'package:plantholic/app_colors.dart';

import '../../NetworkHandler.dart';
import 'components/bottom_action_buttons.dart';
import 'components/patient_data.dart';
import 'components/top_header_appointment.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({Key key}) : super(key: key);

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {

  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Grey,
      appBar: AppBar(
        backgroundColor: AppColors.Green,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          TopHeader(profileModel: profileModel,),
          PatientData(profileModel: profileModel,),
          BottomActionButtons()
        ],
      ),
    );
  }
}
