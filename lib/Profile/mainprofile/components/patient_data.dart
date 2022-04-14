import 'package:flutter/material.dart';
import 'package:plantholic/Model/profileModel.dart';

import '../../../NetworkHandler.dart';
import '../../../app_colors.dart';
import 'attachment_tile.dart';

class PatientData extends StatefulWidget {
  const PatientData({
    Key key,
    this.profileModel
  }) : super(key: key);
final ProfileModel profileModel;
  @override
  State<PatientData> createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {


  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 20,
      ),
      child: widget.profileModel.img==null?CircularProgressIndicator(color: AppColors.Green,):Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.profileModel.name,
            style: TextStyle(
              fontFamily: 'Butler',
                  fontWeight: FontWeight.bold,
                  color: AppColors.Blue,
              fontSize: 40
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'about : ',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.Green,
                fontSize: 18
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.profileModel.about,
            style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: AppColors.Blue,
                ),
          ),
        ],
      ),
    );
  }
}
